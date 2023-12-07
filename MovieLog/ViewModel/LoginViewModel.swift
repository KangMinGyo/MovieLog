//
//  LoginViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 12/5/23.
//

import UIKit
import Combine
import FirebaseAuth
import CryptoKit
import AuthenticationServices

class LoginViewModel: NSObject {
    fileprivate var currentNonce: String?
    
    var subscriptions = Set<AnyCancellable>()
    @Published var signInComplete: Bool = false

    func AppleLogin() {
        let nonce = randomNonceString()
        currentNonce = nonce
        
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
    
    func login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        // Firebase Auth Login
        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
            if authResult != nil {
                print("로그인 성공")
                completion(true, nil)
            } else {
                print("로그인 실패")
                print(error.debugDescription)
                completion(false, nil)
            }
        }
    }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    // 애플 로그인 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }
    
    // 애플 로그인 성공
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                debugPrint("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            FirebaseManager.shared.auth.signIn(with: credential) { (result, error) in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
                self.signInComplete = true
                print("Loggen In Success: \(result?.user.email ?? "")")
            }
        }
    }
}

extension LoginViewModel {
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
}

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

class LoginViewModel {
    
    var subscriptions = Set<AnyCancellable>()
    
    private var apple: AppleAuthentication
    
    init(_ apple: AppleAuthentication) {
        self.apple = apple
    }
    
    // 체크박스 누르면 -> isLoggedIn True -> true면 UserDefault에 아이디 저장 및 다음에 자동로그인
    @Published var isLoggedIn: Bool = false
    
    func AppleLogin() {
        apple.startSignInWithAppleFlow()
    }
    
//    func saveLogin(email: String, password: String) {
//        UserDefaults.standard.set(email, forKey: "email")
//        UserDefaults.standard.set(password, forKey: "password")
//    }
    
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

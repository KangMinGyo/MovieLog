//
//  SignUpViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 11/25/23.
//

import UIKit
import Combine

class SignUpViewModel {
    
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Input
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""
    
    // MARK: - Output
    
    @Published var emailState: ViewState = .none
    @Published var pwState: ViewState = .none
    @Published var pwCheckState: ViewState = .none
    @Published var state: ViewState = .none
    
    init() {
        isValid()
    }
    
    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isValidEmail() }
            .print("[EMAIL]")
            .eraseToAnyPublisher()
    }
    
    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { $0.isValidPassword() }
            .print("[PASSWORD]")
            .eraseToAnyPublisher()
    }
    
    var isPasswordMatchPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $passwordCheck)
            .map { !$1.isEmpty && $0 == $1 }
            .print("[IS VALID PASSWORDCHECK]")
            .eraseToAnyPublisher()
    }
    
    func isValid() {
        Publishers.CombineLatest3(
            isValidEmailPublisher,
            isValidPasswordPublisher,
            isPasswordMatchPublisher
        )
        .sink { isValidEmail, isValidPassword, isPasswordMatch in
            self.emailState = isValidEmail ? .success : .failed
            self.pwState = isValidPassword ? .success : .failed
            self.pwCheckState = isPasswordMatch ? .success : .failed
            self.state = (isValidEmail && isValidPassword && isPasswordMatch) ? .success : .failed
        }
        .store(in: &subscriptions)
    }
    
    func signUp(email: String, password: String) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { res, err in
            if let err = err {
                print("Failed to cerate user:", err)
                return
            }
            print("Successfully created user: \(res?.user.uid ?? "")")
            self.storeUserInformation(email: email, password: password)
        }
    }
    
    private func storeUserInformation(email: String, password: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["uid": uid,
                        "email": email,
                        "password": password]
        
        FirebaseManager.shared.fireStore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print("Firestore에 사용자 정보 저장 실패: \(err.localizedDescription)")
                } else {
                    print("Firestore에 사용자 정보 저장 성공!")
                    // 필요 시 추가 작업 수행
                }
            }
    }
}

enum ViewState {
    case success
    case failed
    case none
}

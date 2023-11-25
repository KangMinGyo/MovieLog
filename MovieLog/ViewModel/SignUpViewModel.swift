//
//  SignUpViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 11/25/23.
//

import UIKit
import Combine

class SignUpViewModel {
    
    // MARK: Output
    @Published var email: String?
    @Published var password: String?
    @Published var nickname: String?
    
    func signUp(email: String, password: String) {
        if email.i && isValidPassword(password) {
            FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { res, err in
                
                if let err = err {
                    print("Failed to cerate user:", err)
                    return
                }
                print("Successfully created user: \(res?.user.uid ?? "")")
                self.storeUserInformation(email: email, password: password)
            }
        } else {
            print("유효하지 않은 이메일 주소입니다.")
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

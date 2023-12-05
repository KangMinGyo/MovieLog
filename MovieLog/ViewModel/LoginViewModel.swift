//
//  LoginViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 12/5/23.
//

import UIKit
import Combine
import FirebaseAuth

class LoginViewModel {
    
    var subscriptions = Set<AnyCancellable>()
    
//    private func login(email: String, password: String) {
//        // Firebase Auth Login
//        Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
//            if authResult != nil {
//                print("로그인 성공")
//                let vc = HomeViewController()
//                vc.modalPresentationStyle = .fullScreen
//                self.present(vc, animated: false, completion: nil)
//            } else {
//                print("로그인 실패")
//                print(error.debugDescription)
//                self.view.makeToast("아이디와 비밀번호를 다시 확인해주세요.")
//            }
//        }
//    }
}

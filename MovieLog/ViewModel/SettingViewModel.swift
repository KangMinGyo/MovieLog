//
//  SettingViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 2/15/24.
//

import Foundation
import FirebaseAuth

class SettingViewModel: ObservableObject {
    
    @Published var userID: String?
    @Published var isLogin: Bool?
    
    func fetchCurrentUser() {
        if let currentUser = Auth.auth().currentUser {
            guard let email = currentUser.email else { return }
            let components = email.components(separatedBy: "@")
            userID = components.first
            print("사용자의 email: \(email)")
        } else {
            print("사용자가 로그인되어 있지 않습니다.")
        }
    }
    
    func logOutButtonTapped() {
        do {
            try Auth.auth().signOut()
            print("로그아웃 성공")
        } catch let signOutError as NSError {
            print("로그아웃 실패: \(signOutError.localizedDescription)")
        }
    }
    
    func checkLoginStatus() {
        if let currentUser = Auth.auth().currentUser {
            AuthManager.shared.login()
        } else {
            AuthManager.shared.logout()
        }
    }
}

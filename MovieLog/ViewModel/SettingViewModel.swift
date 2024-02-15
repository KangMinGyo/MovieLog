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
}

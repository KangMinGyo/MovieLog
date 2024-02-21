//
//  AuthManager.swift
//  MovieLog
//
//  Created by KangMingyo on 2/21/24.
//

import Foundation

class AuthManager {
    static let shared = AuthManager()

    private init() {}

    func isLoggedIn(_ value: Bool) {
        // 여기에서 로그인 상태를 설정하는 로직을 구현
        // 예: UserDefaults, Keychain 등을 사용하여 로그인 상태를 저장
        UserDefaults.standard.set(value, forKey: "isLoggedIn")
    }
    
    func login() {
        isLoggedIn(true)
    }

    func logout() {
        isLoggedIn(false)
    }
}

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

    var isUserLoggedIn: Bool {
        // 여기에서 실제 로그인 상태를 확인하는 로직을 구현
        // 예: UserDefaults, Keychain 등을 사용하여 로그인 상태를 저장하고 확인
        return UserDefaults.standard.bool(forKey: "isUserLoggedIn")
    }

    func setLoggedIn(_ value: Bool) {
        // 여기에서 로그인 상태를 설정하는 로직을 구현
        // 예: UserDefaults, Keychain 등을 사용하여 로그인 상태를 저장
        UserDefaults.standard.set(value, forKey: "isUserLoggedIn")
    }
    
    func login() {
        setLoggedIn(true)
    }

    func logout() {
        setLoggedIn(false)
    }
}

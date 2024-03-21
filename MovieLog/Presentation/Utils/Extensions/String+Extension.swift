//
//  String+Extension.swift
//  MovieLog
//
//  Created by KangMingyo on 11/25/23.
//

import Foundation

extension String {
    // 이메일 정규식
    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return self.range(of: emailRegex, options: .regularExpression) != nil
    }
    
    // 패스워드 정규식
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*\\d)[a-zA-Z\\d]{8,20}$"
        return self.range(of: passwordRegex, options: .regularExpression) != nil
    }
}


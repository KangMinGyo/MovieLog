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
    
    // 누적 관객 수 만 단위로 변경
    func formattedAudiAcc() -> String {
        guard let audiAccNum = Int(self), audiAccNum >= 10000 else {
            return self
        }
        return "\(audiAccNum / 10000)만"
    }
    
    // 전일 대비 증감 계산
    func formattedRankInten() -> String {
            guard let rankIntenInt = Int(self) else { return "-" }
            switch rankIntenInt {
            case 0:
                return "-"
            case let x where x > 0:
                return "🔺\(x)"
            default:
                return "🔻\(abs(rankIntenInt))"
            }
        }
}


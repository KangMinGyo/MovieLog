//
//  CustomLabel.swift
//  MovieLog
//
//  Created by KangMingyo on 12/1/23.
//

import UIKit

class CustomLabel: UILabel {
    enum CustomLabelType {
        case email
        case pw
        case pwCheck
    }
    
    private let checkLabelType: CustomLabelType
    
    init(labelType: CustomLabelType) {
        self.checkLabelType = labelType
        super.init(frame: .zero)
        
        self.font = .systemFont(ofSize: 15, weight: .semibold)
        self.textColor = .red

        switch labelType {
        case .email:
            self.text = "사용할 수 없는 이메일입니다."
        case .pw:
            self.text = "비밀번호를 입력하세요(8~20자)"
        case .pwCheck:
            self.text = "비밀번호가 일치하지 않습니다."
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

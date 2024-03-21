//
//  CustomTextField.swift
//  MovieLog
//
//  Created by KangMingyo on 11/23/23.
//

import UIKit

class CustomTextField: UITextField {
    enum CustomTextFieldType {
        case email
        case pw
        case pwCheck
    }
    
    private let loginFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.loginFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none

        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch fieldType {
        case .email:
            self.placeholder = "이메일을 입력하세요"
            self.keyboardType = .emailAddress
        case .pw:
            self.placeholder = "비밀번호를 입력하세요"
            self.isSecureTextEntry = true
            self.textContentType = .password
        case .pwCheck:
            self.placeholder = "비밀번호를 한번 더 입력하세요"
            self.isSecureTextEntry = true
            self.textContentType = .password
            self.clearsOnBeginEditing = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

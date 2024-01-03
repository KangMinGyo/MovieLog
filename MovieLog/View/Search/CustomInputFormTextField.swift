//
//  CustomInputFormTextField.swift
//  MovieLog
//
//  Created by KangMingyo on 1/3/24.
//

import UIKit

class CustomInputFormTextField: UITextField {
    enum CustomTextFieldType {
        case title
        case director
        case nation
        case genre
        case year
    }
    
    private let inputFormFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.inputFormFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none

        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch fieldType {
        case .title:
            self.placeholder = "영화 제목을 입력하세요"
        case .director:
            self.placeholder = "감독명을 입력하세요"
        case .nation:
            self.placeholder = "제작국가를 입력하세요"
        case .genre:
            self.placeholder = "장르를 입력하세요"
        case .year:
            self.placeholder = "개봉년도를 입력하세요"
            self.keyboardType = .numberPad
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

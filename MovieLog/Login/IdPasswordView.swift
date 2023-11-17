//
//  LoginPasswordView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/15/23.
//

import UIKit
import SnapKit
import Then

final class IdPasswordView: UIView {
    
    lazy var loginIcon = UIImageView().then {
        $0.image = UIImage(named: "person")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var loginTextField = UITextField().then {
        $0.placeholder = "아이디를 입력하세요."
    }
    
    lazy var line = UIView().then {
        $0.backgroundColor = .systemGray3
    }

    private func setupConstraints() {
        addSubview(loginIcon)
        addSubview(loginTextField)
        addSubview(line)

        
    }
}

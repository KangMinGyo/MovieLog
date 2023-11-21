//
//  PasswordView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/18/23.
//

import UIKit
import SnapKit
import Then

final class PasswordView: UIView {
    
    // MARK: View Components
    lazy var passwordIcon = UIImageView().then {
        $0.image = UIImage(systemName: "lock")
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력하세요."
    }
    
    lazy var line = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    // MARK: Life Cycle
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(passwordIcon)
        addSubview(passwordTextField)
        addSubview(line)
        
        passwordIcon.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.leading.equalTo(passwordIcon.snp.trailing).offset(10)
            $0.centerY.equalTo(passwordIcon)
        }
        
        line.snp.makeConstraints { 
            $0.top.equalTo(passwordIcon.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(1)
        }
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MyPasswordViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = PasswordView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

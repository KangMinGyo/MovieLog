//
//  LoginPasswordView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/15/23.
//

import UIKit
import SnapKit
import Then

final class IdView: UIView {
    
    // MARK: View Components
    lazy var loginIcon = UIImageView().then {
        $0.image = UIImage(systemName: "person")
        $0.tintColor = .gray
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var loginTextField = UITextField().then {
        $0.placeholder = "아이디를 입력하세요."
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
        addSubview(loginIcon)
        addSubview(loginTextField)
        addSubview(line)
        
        loginIcon.setContentHuggingPriority(.init(rawValue: 100), for: .horizontal)
        loginIcon.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(25)
        }
        
        loginIcon.setContentHuggingPriority(.init(rawValue: 99), for: .horizontal)
        loginTextField.snp.makeConstraints {
            $0.leading.equalTo(loginIcon.snp.trailing).offset(10)
            $0.centerY.equalTo(loginIcon)
        }
        
        line.snp.makeConstraints {
            $0.top.equalTo(loginIcon.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(1)
        }
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MyIdViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = IdView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

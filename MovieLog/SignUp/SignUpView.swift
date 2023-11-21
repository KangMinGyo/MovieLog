//
//  SignUpView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/21/23.
//

import UIKit
import SnapKit
import Then


final class SignUpView: UIView {
    // MARK: View Components
    lazy var idTextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var idLine = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor")
    }
    
    lazy var pwTextField = UITextField().then {
        $0.placeholder = "비밀번호"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var pwLine = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor")
    }
    
    lazy var pwcheckTextField = UITextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var pwcheckLine = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor")
    }
    
    lazy var nickTextField = UITextField().then {
        $0.placeholder = "닉네임"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var nickLine = UIView().then {
        $0.backgroundColor = UIColor(named: "MainColor")
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
        addSubview(idTextField)
        addSubview(idLine)
        addSubview(pwTextField)
        addSubview(pwLine)
        addSubview(pwcheckTextField)
        addSubview(pwcheckLine)
        addSubview(nickTextField)
        addSubview(nickLine)
        
        idTextField.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        idLine.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(1)
        }
        
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(idLine.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        pwLine.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(1)
        }
        
        pwcheckTextField.snp.makeConstraints {
            $0.top.equalTo(pwLine.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        pwcheckLine.snp.makeConstraints {
            $0.top.equalTo(pwcheckTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(1)
        }
        
        nickTextField.snp.makeConstraints {
            $0.top.equalTo(pwcheckLine.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nickLine.snp.makeConstraints {
            $0.top.equalTo(nickTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(1)
        }
        
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MySignUpViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = SignUpView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

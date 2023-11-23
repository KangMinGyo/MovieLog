//
//  SignUpPasswordView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/21/23.
//

import UIKit
import SnapKit
import Then

final class SignUpPasswordView: UIView {
    // MARK: View Components
    
    lazy var pwTextField = UITextField().then {
        $0.placeholder = "비밀번호 확인"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var pwLine = UIView().then {
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
        addSubview(pwTextField)
        addSubview(pwLine)
        
        pwTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        
        pwLine.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(1)
        }
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MySignUpPasswordViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = SignUpPasswordView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

//
//  SignUpNicknameView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/21/23.
//

import UIKit
import SnapKit
import Then

final class SignUpNicknameView: UIView {
    // MARK: View Components

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

        addSubview(nickTextField)
        addSubview(nickLine)

        nickTextField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
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

struct MySignUpNicknameViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = SignUpNicknameView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

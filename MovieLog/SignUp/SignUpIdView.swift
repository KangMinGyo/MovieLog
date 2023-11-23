//
//  SignUpIdView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/21/23.
//

import UIKit
import SnapKit
import Then

final class SignUpIdView: UIView {
    
    // MARK: View Components
    lazy var idTextField = UITextField().then {
        $0.placeholder = "아이디"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var idLine = UIView().then {
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
        
        idTextField.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
        }
        
        idLine.snp.makeConstraints {
            $0.top.equalTo(idTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(self.frame.width)
            $0.height.equalTo(1)
        }
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MySignUpIdViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = SignUpIdView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

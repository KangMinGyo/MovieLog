//
//  InfoFindView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/18/23.
//

import UIKit
import SnapKit
import Then
import Combine

final class InfoFindView: UIView {
    
    lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    
    lazy var idFindButton = UIButton().then {
        $0.setTitle("아이디찾기", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
        $0.backgroundColor = .systemBackground
    }
    
    lazy var pwFindButton = UIButton().then {
        $0.setTitle("비밀번호찾기", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
        $0.backgroundColor = .systemBackground
    }
    
    lazy var signUpButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.systemGray, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 15)
        $0.backgroundColor = .systemBackground
    }
    
    // MARK: Life Cycle
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        setupConstraints()
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout Views
    func setupConstraints() {
        addSubview(stackView)
        stackView.addArrangedSubview(idFindButton)
        stackView.addArrangedSubview(pwFindButton)
        stackView.addArrangedSubview(signUpButton)
        
        for v in stackView.arrangedSubviews {
            v.snp.makeConstraints {
                $0.width.equalTo(100)
            }
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(50)
        }
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MyInfoFindViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = InfoFindView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

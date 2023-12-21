//
//  SignUpHeaderView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/23/23.
//

import UIKit
import SnapKit
import Then

final class SignUpHeaderView: UIView {
    
    // MARK: - UI Components
    lazy var titleLabel = UILabel().then {
        $0.text = "회원가입"
        $0.textColor = UIColor(named: "MainColor")
        $0.font = .systemFont(ofSize: 38, weight: .bold)
    }
    
    lazy var subTitleLabel = UILabel().then {
        $0.text = "이메일과 비밀번호로 \n간편하게 무비로그를 시작하세요!"
        $0.textColor = .systemGray
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.numberOfLines = 2
    }
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setupConstraints() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(self.frame.width)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(self.frame.width)
        }
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct HeaderViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = SignUpHeaderView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

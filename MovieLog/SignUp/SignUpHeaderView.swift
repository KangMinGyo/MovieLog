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
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(self.frame.width)
        }
    }
}
    


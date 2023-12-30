//
//  LoginHeaderView.swift
//  MovieLog
//
//  Created by KangMingyo on 11/23/23.
//

import UIKit
import SnapKit
import Then

final class LoginHeaderView: UIView {
    
    // MARK: - UI Components
    lazy var logoImage = UIImageView().then {
        $0.image = UIImage(named: "LogoImage")
        $0.contentMode = .scaleAspectFit
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
        addSubview(logoImage)
        
        logoImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(self.frame.width)
        }
    }
}
    

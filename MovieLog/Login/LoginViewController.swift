//
//  ViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 11/14/23.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {
    
    lazy var logoImage = UIImageView().then {
        $0.image = UIImage(named: "LogoImage")
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var loginStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fillEqually
    }

    lazy var idView = IdView().then {
        $0.backgroundColor = .systemBackground
    }
    
    lazy var passwordView = PasswordView().then {
        $0.backgroundColor = .systemBackground
    }
    
    lazy var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 30
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(logoImage)
        view.addSubview(loginStackView)
        view.addSubview(loginButton)
        
        loginStackView.addArrangedSubview(idView)
        loginStackView.addArrangedSubview(passwordView)

        logoImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(view.frame.width)
        }
        
        for v in loginStackView.arrangedSubviews {
            v.snp.makeConstraints {
                $0.height.equalTo(80)
            }
        }
        
        loginStackView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(160)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(loginStackView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyLoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = LoginViewController()
            return vc
        }
    }
}
#endif

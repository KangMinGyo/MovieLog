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
    // ScrollView안에 ContentView의 자식으로 다른 요소들 다 넣어!
    
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    
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
    
    lazy var infoFindView = InfoFindView().then {
        $0.backgroundColor = .systemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logoImage)
        contentView.addSubview(loginStackView)
        contentView.addSubview(loginButton)
        contentView.addSubview(infoFindView)
        
        loginStackView.addArrangedSubview(idView)
        loginStackView.addArrangedSubview(passwordView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.leading.trailing.equalTo(view)
        }

        logoImage.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.trailing.equalTo(contentView)
            $0.width.equalTo(view.frame.width)
        }
        
        for v in loginStackView.arrangedSubviews {
            v.snp.makeConstraints {
                $0.height.equalTo(80)
            }
        }
        
        loginStackView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom)
            $0.leading.trailing.equalTo(contentView).inset(40)
            $0.height.equalTo(160)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(loginStackView.snp.bottom)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(60)
        }
        
        infoFindView.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).inset(-10)
            $0.leading.trailing.equalTo(contentView).inset(20)
            $0.height.equalTo(1000)
            $0.bottom.equalToSuperview()
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

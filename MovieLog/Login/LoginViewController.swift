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
    
//    lazy var loginStackView = UIStackView().then {
//        $0.axis = .vertical
//        $0.spacing = 10
//    }

    lazy var idView = IdView().then {
        $0.backgroundColor = .systemBackground
    }
    
    lazy var passwordView = PasswordView().then {
        $0.backgroundColor = .systemBackground
    }
    
//    lazy var logoImage: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "LogoImage")
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
    
//    lazy var idView: IdView = {
//        let view = IdView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    
//    lazy var passwordView: PasswordView = {
//        let view = PasswordView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupConstraints()
    }

    func setupConstraints() {
        view.addSubview(logoImage)
//        loginStackView.addArrangedSubview(idView)
//        loginStackView.addArrangedSubview(passwordView)
        
        view.addSubview(idView)
        view.addSubview(passwordView)
        
        logoImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(view.frame.width)
        }
        
        idView.snp.makeConstraints {
            $0.top.equalTo(logoImage.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(80)
        }

        passwordView.snp.makeConstraints {
            $0.top.equalTo(idView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(40)
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

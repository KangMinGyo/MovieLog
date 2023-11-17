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
//        view.addSubview(idView)
//        view.addSubview(passwordView)
        
        logoImage.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
    }
}

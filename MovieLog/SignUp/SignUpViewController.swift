//
//  SignUpViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 11/21/23.
//

import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    
    lazy var signUpIdView = SignUpIdView()
    lazy var signUpPasswordView = SignUpPasswordView()
    lazy var signUpPasswordCheckView = SignUpPasswordCheckView()
    lazy var signUpNicknameView = SignUpNicknameView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(signUpIdView)
        stackView.addArrangedSubview(signUpPasswordView)
        stackView.addArrangedSubview(signUpPasswordCheckView)
        stackView.addArrangedSubview(signUpNicknameView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MySignUpViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = SignUpViewController()
            return vc
        }
    }
}
#endif

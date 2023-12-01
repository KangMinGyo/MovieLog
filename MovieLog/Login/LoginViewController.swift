//
//  ViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 11/14/23.
//

import UIKit
import SnapKit
import Then
import Combine
import FirebaseAuth
import Toast

class LoginViewController: UIViewController {
    
//    let viewModel: LoginViewModel = LoginViewModel()
//    var subscriptions = Set<AnyCancellable>()

    // MARK: - UI Components
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    
    lazy var loginHeaderView = LoginHeaderView()
    lazy var idField = CustomTextField(fieldType: .email)
    lazy var pwField = CustomTextField(fieldType: .pw)
    lazy var signInButton = CustomButton(title: "로그인", hasBackground: true, fontSize: .big)
    lazy var signUpButton = CustomButton(title: "회원이 아니신가요? 회원가입하기", hasBackground: false, fontSize: .small)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        
        self.signInButton.addTarget(self, action: #selector(signInButtonCliked), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(signUpButtonCliked), for: .touchUpInside)
    }

    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(loginHeaderView)
        contentView.addSubview(idField)
        contentView.addSubview(pwField)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints {
            $0.top.bottom.equalTo(scrollView)
            $0.leading.trailing.equalTo(view)
        }

        loginHeaderView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.trailing.equalTo(contentView)
            $0.height.equalTo(180)
        }

        idField.snp.makeConstraints {
            $0.top.equalTo(loginHeaderView.snp.bottom)
            $0.leading.trailing.equalTo(contentView).inset(40)
            $0.height.equalTo(55)
        }
        
        pwField.snp.makeConstraints {
            $0.top.equalTo(idField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(40)
            $0.height.equalTo(55)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(pwField.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(40)
            $0.height.equalTo(60)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(20)
//            $0.height.equalTo(500)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Selectors
    @objc private func signInButtonCliked() {
        let email: String = idField.text!.description
        let pw: String = pwField.text!.description
        
        // Firebase Auth Login
        Auth.auth().signIn(withEmail: email, password: pw) {authResult, error in
            if authResult != nil {
                print("로그인 성공")
                let vc = HomeViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            } else {
                print("로그인 실패")
                print(error.debugDescription)
                self.view.makeToast("아이디와 비밀번호를 다시 확인해주세요.")
            }
        }
    }
    
    @objc private func signUpButtonCliked() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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

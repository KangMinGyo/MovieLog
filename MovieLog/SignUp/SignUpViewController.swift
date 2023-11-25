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
    
    var viewModel: SignUpViewModel!
    
    // MARK: - UI Components
    lazy var loginHeaderView = SignUpHeaderView()
    lazy var idField = CustomTextField(fieldType: .email)
    lazy var pwField = CustomTextField(fieldType: .pw)
    lazy var pwCheckField = CustomTextField(fieldType: .pwCheck)
    lazy var nicknameField = CustomTextField(fieldType: .nickname)
    lazy var signInButton = CustomButton(title: "회원가입", hasBackground: true, fontSize: .big)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = .systemBackground
        setupConstraints()
        
        self.signInButton.addTarget(self, action: #selector(signInButtonCliked), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupConstraints() {
        view.addSubview(loginHeaderView)
        view.addSubview(idField)
        view.addSubview(pwField)
        view.addSubview(pwCheckField)
        view.addSubview(nicknameField)
        view.addSubview(signInButton)
        
        loginHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(80)
        }
        
        idField.snp.makeConstraints {
            $0.top.equalTo(loginHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(55)
        }
        
        pwField.snp.makeConstraints {
            $0.top.equalTo(idField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(55)
        }
        
        pwCheckField.snp.makeConstraints {
            $0.top.equalTo(pwField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(55)
        }
        
        nicknameField.snp.makeConstraints {
            $0.top.equalTo(pwCheckField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(55)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(nicknameField.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Selectors
    @objc private func signInButtonCliked() {
        guard let email = idField.text else { return }
        guard let password = pwCheckField.text else { return }
        print("email: \(email)")
        print("password: \(password)")
        viewModel.signUp(email: email, password: "\(password)")
        self.navigationController?.popViewController(animated: true)
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

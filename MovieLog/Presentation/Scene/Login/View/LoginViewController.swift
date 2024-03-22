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

    var viewModel = LoginViewModel()
    var subscriptions = Set<AnyCancellable>()

    // MARK: - UI Components
    lazy var scrollView = UIScrollView()
    lazy var contentView = CustomStackView()
    lazy var loginHeaderView = LoginHeaderView()
    lazy var idField = CustomTextField(fieldType: .email)
    lazy var pwField = CustomTextField(fieldType: .pw)
    lazy var checkButton = CustomCheckbox(title: "자동로그인")
    lazy var signInButton = CustomButton(title: "로그인", hasBackground: true, fontSize: .big)
    lazy var signUpButton = CustomButton(title: "회원이 아니신가요? 회원가입하기", hasBackground: false, fontSize: .small)
    let appleLoginButton = ASAuthorizationAppleIDButton(type: .signIn, style: .black)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bind(viewModel: viewModel)
        setupConstraints()
        setupDelegates()
        print("APPLE 1 --> \(self.viewModel.signInComplete)")
    }

    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(loginHeaderView)
        contentView.addSubview(idField)
        contentView.addSubview(pwField)
        contentView.addSubview(checkButton)
        contentView.addSubview(signInButton)
        contentView.addSubview(signUpButton)
        contentView.addSubview(appleLoginButton)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(800)
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
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(pwField.snp.bottom).offset(10)
            $0.leading.equalTo(contentView).inset(30)
        }
        
        signInButton.snp.makeConstraints {
            $0.top.equalTo(checkButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(40)
            $0.height.equalTo(60)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(signInButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(20)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(contentView).inset(40)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Binding
    func bind(viewModel: LoginViewModel) {
        signInButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                guard let email = self?.idField.text else { return }
                guard let pw = self?.pwField.text else { return }
                viewModel.login(email: email, password: pw) { success, err in
                    if success {
                        let vc = HomeViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc, animated: false, completion: nil)
                    } else {
                        self?.view.endEditing(true)
                        self?.view.makeToast("아이디와 비밀번호를 다시 확인해주세요.")
                    }
                }
            }.store(in: &subscriptions)
        
        checkButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                guard let email = self?.idField.text else { return }
                guard let pw = self?.pwField.text else { return }
                viewModel.autoLogin(email: email, password: pw)
            }.store(in: &subscriptions)
        
        signUpButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                let vc = SignUpViewController()
//                self?.navigationController?.pushViewController(vc, animated: true)
                self?.present(vc, animated: false, completion: nil)
            }.store(in: &subscriptions)
        
        appleLoginButton.controlEvent(.touchUpInside)
            .sink { _ in
                print("APPLE 2 --> \(self.viewModel.signInComplete)")
                viewModel.AppleLogin()
                print("APPLE 3 --> \(self.viewModel.signInComplete)")
            }.store(in: &subscriptions)
        
        viewModel.$signInComplete
            .sink { [weak self] state in
                if state {
                    print("APPLE 4 --> \(state)")
                    AuthManager.shared.login()
                    NotificationCenter.default.post(name: Notification.Name("LoginStatusChanged"), object: nil)
                    self?.dismiss(animated: true) {
                        let homeViewController = HomeViewController()
                        self?.navigationController?.pushViewController(homeViewController, animated: true)
                    }
                }
            }.store(in: &subscriptions)
    }

    // MARK: - Text Field Delegates
    private func setupDelegates() {
        idField.delegate = self
        pwField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idField {
            pwField.becomeFirstResponder() // pwField로 커서 이동
        }
        if textField == pwField {
            textField.resignFirstResponder() // 키보드 숨기기
        }
        return true
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
import AuthenticationServices

struct MyLoginViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = LoginViewController()
            return vc
        }
    }
}
#endif

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

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bind(viewModel: viewModel)
        setupConstraints()
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
    }
    
    // MARK: - Selectors
    @objc private func signUpButtonCliked() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
                        self?.view.makeToast("아이디와 비밀번호를 다시 확인해주세요.")
                    }
                }
            }.store(in: &subscriptions)
        
        signUpButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                self?.signUpButtonCliked()
            }.store(in: &subscriptions)
    }
    
//    func autoLogin() {
//        if let id = UserDefaults.standard.string(forKey: "id") {
//            if let pw = UserDefaults.standard.string(forKey: "pw") {
//                Auth.auth().signIn(withEmail: id, password: pw) {authResult, error in
//                    if authResult != nil {
//                        print("로그인 성공")
//                        let vc = HomeViewController()
//                        vc.modalPresentationStyle = .fullScreen
//                        self.present(vc, animated: false, completion: nil)
//                    } else {
//                        print("로그인 실패")
//                        print(error.debugDescription)
//                        self.view.makeToast("아이디와 비밀번호를 다시 확인해주세요.")
//                    }
//                }
//            }
//        }
//    }
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

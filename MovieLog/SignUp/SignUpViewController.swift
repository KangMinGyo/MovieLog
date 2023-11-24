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
        guard let email = idField.text?.description else { return }
        guard let password = pwCheckField.text?.description else { return }
        signUp(email: email, password: password)
        self.navigationController?.popViewController(animated: true)
    }
    
    func signUp(email: String, password: String) {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { res, err in
            if let err = err {
                print("Failed to cerate user:", err)
                return
            }
            print("Successfully created user: \(res?.user.uid ?? "")")
            self.storeUserInformation(email: email, password: password)
        }
    }
    
    private func storeUserInformation(email: String, password: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let userData = ["uid": uid,
                        "email": email,
                        "password": password]
        
        FirebaseManager.shared.fireStore.collection("users")
            .document(uid).setData(userData) { err in
                if let err = err {
                    print("Firestore에 사용자 정보 저장 실패: \(err.localizedDescription)")
                } else {
                    print("Firestore에 사용자 정보 저장 성공!")
                    // 필요 시 추가 작업 수행
                }
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

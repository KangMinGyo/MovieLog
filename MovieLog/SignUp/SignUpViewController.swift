//
//  SignUpViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 11/21/23.
//

import UIKit
import SnapKit
import Then
import Combine

class SignUpViewController: UIViewController {
    
    var viewModel =  SignUpViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var headerView = SignUpHeaderView()
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    
    lazy var idField = CustomTextField(fieldType: .email)
    lazy var idLabel = CustomLabel(labelType: .email)
    
    lazy var pwField = CustomTextField(fieldType: .pw)
    lazy var pwLabel = CustomLabel(labelType: .pw)
    
    lazy var pwCheckField = CustomTextField(fieldType: .pwCheck)
    lazy var pwCheckLabel = CustomLabel(labelType: .pwCheck)
    
    lazy var signUpButton = CustomButton(title: "회원가입", hasBackground: true, fontSize: .big)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupConstraints()
        bind(viewModel: SignUpViewModel())
        
        self.signUpButton.addTarget(self, action: #selector(signUpButtonCliked), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupConstraints() {
        view.addSubview(headerView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(idField)
        contentView.addSubview(idLabel)
        
        contentView.addSubview(pwField)
        contentView.addSubview(pwLabel)
        
        contentView.addSubview(pwCheckField)
        contentView.addSubview(pwCheckLabel)
        
        contentView.addSubview(signUpButton)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }

        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(600)
        }
        
        idField.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalTo(idField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        pwField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        pwLabel.snp.makeConstraints {
            $0.top.equalTo(pwField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        pwCheckField.snp.makeConstraints {
            $0.top.equalTo(pwLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(55)
        }
        
        pwCheckLabel.snp.makeConstraints {
            $0.top.equalTo(pwCheckField.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(20)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(pwCheckLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
    }
    
    // MARK: - Selectors
    @objc private func signUpButtonCliked() {
//        guard let email = idField.text else { return }
//        guard let password = pwCheckField.text else { return }
//        print("email: \(email)")
//        print("password: \(password)")
//        viewModel.signUp(email: email, password: "\(password)")
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Binding
    func bind(viewModel: SignUpViewModel) {
        idField.publisher
            .receive(on: RunLoop.main)
            .assign(to: \.email, on: viewModel)
            .store(in: &subscriptions)
        
        pwField.publisher
            .receive(on: RunLoop.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
        
        pwCheckField.publisher
            .receive(on: RunLoop.main)
            .assign(to: \.passwordCheck, on: viewModel)
            .store(in: &subscriptions)
        
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                case .none:
                    self?.signUpButton.isEnabled = false
                    self?.signUpButton.backgroundColor = .gray
                case .success:
                    self?.signUpButton.isEnabled = true
                    self?.signUpButton.backgroundColor = UIColor(named: "MainColor")
                case .failed:
                    self?.signUpButton.isEnabled = false
                    self?.signUpButton.backgroundColor = .gray
                }
            }
            .store(in: &subscriptions)
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


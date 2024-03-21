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
import MovieLog_Resource

class SignUpViewController: UIViewController {
    
    var viewModel =  SignUpViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var headerView = SignUpHeaderView()
    lazy var scrollView = UIScrollView()
    lazy var contentView = CustomStackView()
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
        setupViews()
        setupConstraints()
        setupDelegates()
    }
    
    // MARK: - Setup Views
    func setupViews() {
        navigationController?.navigationBar.tintColor = .systemGray
        view.backgroundColor = .systemBackground
        bind(viewModel: viewModel) //이거
        self.hideKeyboardWhenTappedAround() //이거 옮겨
    }
    
    // MARK: - UI Setup
    private func setupConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        contentView.addSubview(idField)
        contentView.addSubview(idLabel)
        contentView.addSubview(pwField)
        contentView.addSubview(pwLabel)
        contentView.addSubview(pwCheckField)
        contentView.addSubview(pwCheckLabel)
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
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(100)
        }
        
        idField.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(20)
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
            $0.top.equalTo(pwCheckLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(60)
        }
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
        
        signUpButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                guard let email = self?.idField.text else { return }
                guard let password = self?.pwCheckField.text else { return }
                viewModel.signUp(email: email, password: password)
                self?.navigationController?.popViewController(animated: true)
            }.store(in: &subscriptions)
        
        viewModel.$emailState
            .sink { [weak self] state in
                switch state {
                case .none:
                    self?.idLabel.textColor = .red
                case .success:
                    self?.idLabel.text = "사용가능한 이메일입니다."
                    self?.idLabel.textColor = R.Color.green
                case .failed:
                    self?.idLabel.text = "사용할 수 없는 이메일입니다."
                    self?.idLabel.textColor = .red
                }
            }.store(in: &subscriptions)
        
        viewModel.$pwState
            .sink { [weak self] state in
                switch state {
                case .none:
                    self?.pwLabel.textColor = .red
                case .success:
                    self?.pwLabel.text = "사용가능한 비밀번호입니다."
                    self?.pwLabel.textColor = R.Color.green
                case .failed:
                    self?.pwLabel.text = "비밀번호를 입력하세요(영문+숫자/8~20자)"
                    self?.pwLabel.textColor = .red
                }
            }.store(in: &subscriptions)
        
        viewModel.$pwCheckState
            .sink { [weak self] state in
                switch state {
                case .none:
                    self?.pwCheckLabel.textColor = .red
                case .success:
                    self?.pwCheckLabel.text = "비밀번호가 일치합니다."
                    self?.pwCheckLabel.textColor = UIColor(named: "MainColor")
                case .failed:
                    self?.pwCheckLabel.text = "비밀번호가 일치하지 않습니다."
                    self?.pwCheckLabel.textColor = .red
                }
            }.store(in: &subscriptions)
        
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
            }.store(in: &subscriptions)
    }
    
    // MARK: - Text Field Delegates
    private func setupDelegates() {
        idField.delegate = self
        pwField.delegate = self
        pwCheckField.delegate = self
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == idField {
            pwField.becomeFirstResponder() // pwField로 커서 이동
        }
        if textField == pwField {
            pwCheckField.becomeFirstResponder() // pwCheckField로 커서 이동
        }
        if textField == pwCheckField {
             textField.resignFirstResponder() // 키보드 숨기기
         }
        return true
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

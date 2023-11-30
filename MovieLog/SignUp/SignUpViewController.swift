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
    lazy var loginHeaderView = SignUpHeaderView()
    lazy var idField = CustomTextField(fieldType: .email)
    lazy var pwField = CustomTextField(fieldType: .pw)
    lazy var pwCheckField = CustomTextField(fieldType: .pwCheck)
    lazy var nicknameField = CustomTextField(fieldType: .nickname)
    lazy var signUpButton = CustomButton(title: "회원가입", hasBackground: true, fontSize: .big)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.backgroundColor = .systemBackground
        setupConstraints()
        bind(viewModel: SignUpViewModel())
        
        self.signUpButton.addTarget(self, action: #selector(signInButtonCliked), for: .touchUpInside)
    }
    
    // MARK: - UI Setup
    private func setupConstraints() {
        view.addSubview(loginHeaderView)
        view.addSubview(idField)
        view.addSubview(pwField)
        view.addSubview(pwCheckField)
        view.addSubview(nicknameField)
        view.addSubview(signUpButton)
        
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
        
        signUpButton.snp.makeConstraints {
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
        
        nicknameField.publisher
            .receive(on: RunLoop.main)
            .assign(to: \.nickname, on: viewModel)
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

extension UITextField {
    /*NotificationCenter.default
    .publisher(for: UITextField.textDidChangeNotification, object: emailTextField)
    .map { ($0.object as! UITextField).text ?? "" }
    .assign(to: \.email, on: viewModel)
    .store(in: &cancellables)
     */
    var publisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self)
            //NotificationCenter로 들어온 notification의 optional 타입 object 프로퍼티를 UITextField로 타입 캐스팅
            .compactMap{ $0.object as? UITextField}
            //text 프로퍼티만 가져오기
            .map{ $0.text ?? "" }    //값이 없는 경우 빈 문자열 반환
            .print("[TEXT]: ")
            .eraseToAnyPublisher()
    }
}

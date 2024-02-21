//
//  SettingViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 2/7/24.
//

import UIKit
import Combine

class SettingViewController: UIViewController {

    var viewModel = SettingViewModel()
    var loginViewModel = LoginViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var profileImage = UIImageView().then {
        $0.image = UIImage(named: "IMG_8368")
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    lazy var nameLabel = UIButton().then {
        $0.setTitle("닉네임", for: .normal)
    }
    
    lazy var modifyButton = UIButton().then {
        $0.setTitle("내 정보 수정", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .clear
    }
    
    lazy var lineView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    lazy var logOutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        $0.setTitleColor(.gray, for: .normal)
        $0.backgroundColor = .clear
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.checkLoginStatus()
        viewModel.fetchCurrentUser()
        setupConstraints()
        updateUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(modifyButton)
        view.addSubview(lineView)
        view.addSubview(logOutButton)
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        modifyButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(modifyButton.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(1)
        }
        
        logOutButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
    
    // MARK: - Binding
    func bind() {
        viewModel.$isLogin
            .sink { [weak self] state in
                self?.updateUI()
            }.store(in: &subscriptions)
        
        viewModel.$userID
            .sink { [weak self] _ in
                self?.nameLabel.setTitle("\(self?.viewModel.userID ?? "")", for: .normal)
                self?.nameLabel.setTitleColor(.black, for: .normal)
            }.store(in: &subscriptions)
        
        nameLabel.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                let vc = LoginViewController()
//                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            }.store(in: &subscriptions)
        
        logOutButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                AuthManager.shared.logout()
                self?.showLogoutAlert()
                self?.viewModel.checkLoginStatus()
                self?.navigationController?.popViewController(animated: true)
            }.store(in: &subscriptions)
    }
    
    func updateUI() {
        print("AuthManager.shared.isUserLoggedIn : \(UserDefaults.standard.bool(forKey: "isLoggedIn"))")
        var isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        if isLoggedIn {
            // 로그인 상태
               viewModel.fetchCurrentUser()
               nameLabel.isEnabled = false
               logOutButton.isHidden = false
           } else {
               // 로그아웃 상태
               profileImage.image = UIImage(systemName: "person")
               DispatchQueue.main.async {
                   self.nameLabel.setTitle("이곳을 눌러 로그인해주세요.", for: .normal)
                   self.nameLabel.setTitleColor(.black, for: .normal)
                }
               nameLabel.isEnabled = true
               logOutButton.isHidden = true
           }
       }
    
    func showLogoutAlert() {
            let alertController = UIAlertController(title: "로그아웃",
                                                    message: "로그아웃 하시겠습니까?",
                                                    preferredStyle: .alert)

            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                // 사용자가 확인하면 로그아웃 수행
                self.viewModel.logOutButtonTapped()
                self.updateUI()
                self.loginViewModel.signInComplete = false
            }
            alertController.addAction(confirmAction)

            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MySettingViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = SettingViewController()
            return vc
        }
    }
}
#endif

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
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var profileImage = UIImageView().then {
        $0.image = UIImage(named: "IMG_8368")
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    lazy var nameLabel = UILabel().then {
        $0.text = "닉네임"
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.fetchCurrentUser()
        setupConstraints()
        bind()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(profileImage.snp.trailing).offset(10)
        }
    }
    
    // MARK: - Binding
    func bind() {
        viewModel.$user
            .sink { [weak self] _ in
                self?.nameLabel.text = self?.viewModel.user?.email
            }.store(in: &subscriptions)
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

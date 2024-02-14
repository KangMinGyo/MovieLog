//
//  SettingViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 2/7/24.
//

import UIKit

class SettingViewController: UIViewController {

    // MARK: - UI Components
    lazy var profileImage = UIImageView().then {
        $0.image = UIImage(systemName: "person")
    }
    
    lazy var nameLabel = UILabel().then {
        $0.text = "영화 어땠어요?"
        $0.font = .systemFont(ofSize: 25)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        
        profileImage.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(profileImage.snp.leading)
        }
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

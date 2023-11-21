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
    
    lazy var signUpView = SignUpView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(signUpView)
        
        signUpView.snp.makeConstraints {
            $0.edges.equalTo(view)
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

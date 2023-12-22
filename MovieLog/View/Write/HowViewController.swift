//
//  HowViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/22/23.
//

import UIKit
import SnapKit

class HowViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var movieNameLabel = UILabel().then {
        $0.text = "영화 어땠어요?"
    }
    lazy var likeButton = CustomLikeButton(title: "❤️좋았어요", state: .like)
    lazy var hateButton = CustomLikeButton(title: "💔별로였어요", state: .like)
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
    }
    
    lazy var nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = UIColor(named: "MainColor")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupStackView()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(movieNameLabel)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        
        movieNameLabel.snp.makeConstraints {
            $0.top.equalTo(0).inset(20)
            $0.centerX.equalTo(view.snp.centerX)
        }
    }
    
    func setupStackView() {
        [likeButton, hateButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyHowViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = HowViewController()
            return vc
        }
    }
}
#endif

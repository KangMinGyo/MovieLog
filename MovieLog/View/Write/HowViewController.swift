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
        $0.font = .systemFont(ofSize: 25)
    }
    lazy var likeButton = CustomLikeButton(title: "❤️좋았어요", state: .like)
    lazy var hateButton = CustomLikeButton(title: "💔별로였어요", state: .like)
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
    }
    
    lazy var nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 25
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        setupStackView()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(movieNameLabel)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        
        movieNameLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).offset(-60)
        }
        
        likeButton.snp.makeConstraints {
            $0.width.equalTo(150)
        }
        
        hateButton.snp.makeConstraints {
            $0.width.equalTo(150)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.height.equalTo(50)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(0).inset(100)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
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

//
//  WhatViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/23/23.
//

import UIKit

class WhatViewController: UIViewController {
    
    // MARK: - UI Components
    lazy var label = UILabel().then {
        $0.text = "어떤점이 좋았나요?"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var actingButton = CustomSelectButton(select: .acting)
    lazy var directButton = CustomSelectButton(select: .direct)
    lazy var ostButton = CustomSelectButton(select: .ost)
    lazy var visualButton = CustomSelectButton(select: .visual)
    lazy var storyButton = CustomSelectButton(select: .story)
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
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

        setupConstraints()
        setupStackView()
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(label)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        
        label.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).offset(-60)
        }
        
        actingButton.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        
        directButton.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        
        ostButton.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        
        visualButton.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        
        storyButton.snp.makeConstraints {
            $0.width.equalTo(50)
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
        [actingButton, directButton, ostButton, visualButton, storyButton].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyWhatViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = WhatViewController()
            return vc
        }
    }
}
#endif

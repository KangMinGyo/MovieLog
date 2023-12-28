//
//  WhatViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/23/23.
//

import UIKit
import Combine

class WhatViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    
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
    
    lazy var actingLabel = UILabel().then {
        $0.text = "연기"
    }
    
    lazy var directLabel = UILabel().then {
        $0.text = "연출"
    }
    
    lazy var ostLabel = UILabel().then {
        $0.text = "OST"
    }
    
    lazy var visualLabel = UILabel().then {
        $0.text = "영상미"
    }
    
    lazy var storyLabel = UILabel().then {
        $0.text = "스토리"
    }
    
    let actingStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
    }
    
    let directStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
    }
    
    let ostStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
    }
    
    let visualStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
    }
    
    let storyStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
    }
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fillEqually
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
        bind()
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
        
        stackView.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(0).inset(100)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
    }
    
    func setupStackView() {
        [actingButton, actingLabel].forEach {
            self.actingStackView.addArrangedSubview($0)
        }
        
        [directButton, directLabel].forEach {
            self.directStackView.addArrangedSubview($0)
        }
        
        [ostButton, ostLabel].forEach {
            self.ostStackView.addArrangedSubview($0)
        }
        
        [storyButton, storyLabel].forEach {
            self.storyStackView.addArrangedSubview($0)
        }
        
        [visualButton, visualLabel].forEach {
            self.visualStackView.addArrangedSubview($0)
        }
        
        [actingStackView, directStackView, ostStackView, storyStackView, visualStackView].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
    
    // MARK: - Binding
    func bind() {
        nextButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                let vc = WriteViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
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

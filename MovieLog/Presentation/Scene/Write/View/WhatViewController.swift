//
//  WhatViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/23/23.
//

import UIKit
import Combine
import MovieLog_Resource

class WhatViewController: UIViewController {
    
    let imageSize = CGSize(width: 50, height: 50)
    var searchData: MovieList?
    var howData: String?
    var goodPointSelected = [false, false, false, false, false]
    var viewModel = WriteViewModel()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var label = UILabel().then {
        $0.text = "whatMessage".localized
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var actingButton = UIButton().then {
        let image = R.Image.acting.resize(targetSize: imageSize)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(goodPointButtonAction), for: .touchUpInside)
        $0.tag = 0
    }
    lazy var directButton = UIButton().then {
        let image = R.Image.direct.resize(targetSize: imageSize)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(goodPointButtonAction), for: .touchUpInside)
        $0.tag = 1
    }
    
    lazy var ostButton = UIButton().then {
        let image = R.Image.music.resize(targetSize: imageSize)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(goodPointButtonAction), for: .touchUpInside)
        $0.tag = 2
    }
    
    lazy var storyButton = UIButton().then {
        let image = R.Image.story.resize(targetSize: imageSize)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(goodPointButtonAction), for: .touchUpInside)
        $0.tag = 3
    }
    
    lazy var visualButton = UIButton().then {
        let image = R.Image.video.resize(targetSize: imageSize)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(goodPointButtonAction), for: .touchUpInside)
        $0.tag = 4
    }

    lazy var actingLabel = UILabel().then {
        $0.text = "acting".localized
        $0.font = .systemFont(ofSize: 12)
    }
    
    lazy var directLabel = UILabel().then {
        $0.text = "direct".localized
        $0.font = .systemFont(ofSize: 12)
    }
    
    lazy var ostLabel = UILabel().then {
        $0.text = "ost".localized
        $0.font = .systemFont(ofSize: 12)
    }
    
    lazy var visualLabel = UILabel().then {
        $0.text = "visual".localized
        $0.font = .systemFont(ofSize: 12)
        $0.numberOfLines = 0
    }
    
    lazy var storyLabel = UILabel().then {
        $0.text = "story".localized
        $0.font = .systemFont(ofSize: 12)
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
        $0.setTitle("next".localized, for: .normal)
        $0.backgroundColor = R.Color.green
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
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        view.addSubview(label)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        
        label.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).offset(-80)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).inset(20)
            $0.leading.trailing.equalTo(0).inset(20)
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
        actingStackView.distribution = .fillEqually
        directStackView.distribution = .fillEqually
        ostStackView.distribution = .fillEqually
        storyStackView.distribution = .fillEqually
        visualStackView.distribution = .fillEqually
        
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
                vc.searchData = self?.searchData
                vc.howData = self?.howData
                vc.whatData = self!.goodPointSelected
                self?.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &subscriptions)
    }
    
    @objc func goodPointButtonAction(sender: UIButton) {
        if sender.tag == 0 {
            goodPointSelected[0].toggle()
            actingLabel.textColor = goodPointSelected[0] ? R.Color.red : .black
        } else if sender.tag == 1 {
            goodPointSelected[1].toggle()
            directLabel.textColor = goodPointSelected[1] ? R.Color.red : .black
        } else if sender.tag == 2 {
            goodPointSelected[2].toggle()
            ostLabel.textColor = goodPointSelected[2] ? R.Color.red : .black
        } else if sender.tag == 3 {
            goodPointSelected[3].toggle()
            storyLabel.textColor = goodPointSelected[3] ? R.Color.red : .black
        } else {
            goodPointSelected[4].toggle()
            visualLabel.textColor = goodPointSelected[4] ? R.Color.red : .black
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

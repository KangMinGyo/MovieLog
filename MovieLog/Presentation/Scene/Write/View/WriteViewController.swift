//
//  WriteViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/26/23.
//

import UIKit
import Combine
import MovieLog_Resource

class WriteViewController: UIViewController {
    
    var viewModel = WriteViewModel()
    var searchData: MovieList?
    var howData: String?
    var whatData = [Bool]()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var label = UILabel().then {
        $0.text = "writeReview".localized
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var reviewTextView = UITextView().then {
        $0.text = "enterMessage".localized
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = .lightGray
        $0.backgroundColor = .systemGray6
        $0.isScrollEnabled = false
    }
    
    lazy var registerButton = UIButton().then {
        $0.setTitle("register".localized, for: .normal)
        $0.backgroundColor = R.Color.green
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 25
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        reviewTextView.delegate = self
        self.hideKeyboardWhenTappedAround()
        setupConstraints()
        fetchPoster()
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
        view.addSubview(reviewTextView)
        view.addSubview(registerButton)
        
        label.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY).offset(-view.frame.height/3)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(view.safeAreaInsets).inset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(200)
        }
        
        registerButton.snp.makeConstraints { 
            $0.top.equalTo(reviewTextView.snp.bottom).offset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Binding
    func bind() {
        registerButton.controlEvent(.touchUpInside)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.searchData = self.searchData
                self.viewModel.howData = self.howData
                self.viewModel.whatData = self.whatData
                self.viewModel.reviewText = self.reviewTextView.text
                self.viewModel.uploadReview()
                self.navigationController?.popToRootViewController(animated: true)
            }.store(in: &subscriptions)
    }
    
    func fetchPoster() {
        viewModel.getMoviePoster(title: self.searchData?.movieNm ?? "")
    }
}

// MARK: - UITextViewDelegate
extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reviewTextView.textColor == UIColor.lightGray {
            reviewTextView.text = ""
            reviewTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if reviewTextView.text.isEmpty {
            reviewTextView.text = "enterMessage".localized
            reviewTextView.textColor = UIColor.lightGray
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyWriteViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = WriteViewController()
            return vc
        }
    }
}
#endif

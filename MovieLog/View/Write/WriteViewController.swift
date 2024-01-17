//
//  WriteViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 12/26/23.
//

import UIKit
import Combine

class WriteViewController: UIViewController {
    
    var viewModel = WriteViewModel()
    var searchData: MovieList?
    var poster: UIImage?
    var howData: String?
    var whatData = [Bool]()
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    lazy var label = UILabel().then {
        $0.text = "관람평"
        $0.font = .systemFont(ofSize: 25)
    }
    
    lazy var reviewTextView = UITextView().then {
        $0.text = "내용을 입력해주세요."
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = .lightGray
        $0.backgroundColor = .systemGray6
        $0.isScrollEnabled = false
    }
    
    lazy var registerButton = UIButton().then {
        $0.setTitle("등록", for: .normal)
        $0.backgroundColor = UIColor(named: "MainColor")
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
//            $0.centerY.equalTo(view.snp.centerY)
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
                print("ViewModel ->> \(self.poster)")
                self.viewModel.searchData = self.searchData
                self.viewModel.poster = self.poster
                self.viewModel.howData = self.howData
                self.viewModel.whatData = self.whatData
                self.viewModel.reviewText = self.reviewTextView.text
                if self.poster == nil {
                    self.viewModel.uploadReview()
                } else {
                    self.viewModel.directUploadReview()
                }
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
            reviewTextView.text = "내용을 입력해주세요."
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

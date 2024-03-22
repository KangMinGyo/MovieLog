//
//  ReviewDetailViewController.swift
//  MovieLog
//
//  Created by KangMingyo on 3/21/24.
//

import UIKit
import SnapKit
import Then
import Combine

class ReviewDetailViewController: UIViewController {
    
    var viewModel: ReviewDetailViewModel!
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - UI Components
    let movieNameLabel = UILabel().then {
        $0.text = "영화 제목"
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let dateLabel = UILabel().then {
        $0.text = "작성일"
        $0.textColor = .systemGray2
        $0.font = .systemFont(ofSize: 17)
    }
    
    let posterImageView = UIImageView().then {
        $0.image = UIImage(named: "Poster")
    }
    
    let myReviewLabel = UILabel().then {
        $0.text = "내 관람평"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    let reviewView = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    let likeUnlikeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    let reviewTextView = UITextView().then {
        $0.text = "내용을 입력해주세요."
        $0.font = .systemFont(ofSize: 17)
        $0.backgroundColor = .systemGray6
        $0.isScrollEnabled = false
    }
    
    let tagLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 13)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        bind()
    }
    
    // MARK: - UI Setup
    private func setupConstraints() {
        view.addSubview(movieNameLabel)
        view.addSubview(dateLabel)
        view.addSubview(posterImageView)
        view.addSubview(myReviewLabel)
        view.addSubview(reviewView)
        reviewView.addSubview(likeUnlikeLabel)
        reviewView.addSubview(reviewTextView)
        reviewView.addSubview(tagLabel)

        
        movieNameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(movieNameLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(view.snp.centerX)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(150)
            $0.height.equalTo(230)
        }
        
        myReviewLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.leading.equalTo(view.snp.leading).offset(20)
        }
        
        reviewView.snp.makeConstraints {
            $0.top.equalTo(myReviewLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(150)
        }
        
        likeUnlikeLabel.snp.makeConstraints {
            $0.top.equalTo(reviewView.snp.top).inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
        
        reviewTextView.snp.makeConstraints {
            $0.top.equalTo(likeUnlikeLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        
        tagLabel.snp.makeConstraints {
            $0.bottom.equalTo(reviewView.snp.bottom).inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Binding
    private func bind() {
        viewModel.$review
            .receive(on: RunLoop.main)
            .sink { [weak self] review in
                let url = URL(string: "https://image.tmdb.org/t/p/original\(review.posterURL)")
                self?.posterImageView.kf.setImage(with: url)
                self?.movieNameLabel.text = review.title
                self?.likeUnlikeLabel.text = review.how
                self?.reviewTextView.text = review.review
                self?.tagLabel.text = self?.viewModel.goodPoint()
                if let date = review.date {
                    let dateFormatterManager = DateFormatterManager()
                    let dateString = dateFormatterManager.dateFormatter.string(from: date)
                    self?.dateLabel.text = dateString
                }
                
            }
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MyReviewDetailControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = ReviewDetailViewController()
            return vc
        }
    }
}
#endif

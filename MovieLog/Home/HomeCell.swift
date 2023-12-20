//
//  HomeCell.swift
//  MovieLog
//
//  Created by KangMingyo on 12/20/23.
//

import UIKit
import SnapKit
import Then

class HomeCell: UICollectionViewCell {
    
    static let identifier = "HomeCell"
    
    // MARK: - UI Components
    let posterImageView = UIImageView()
    let movieNameLabel = UILabel()
    let directorNameLabel = UILabel()
    let movieInfoLabel = UILabel()
    let dateLabel = UILabel()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        setup()
        configureShadow()
        configureCornerRadius()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.posterImageView.image = nil
    }
    
    // MARK: - UI Setup
    private func setupConstraints() {
        addSubview(posterImageView)
        addSubview(movieNameLabel)
        addSubview(directorNameLabel)
        addSubview(movieInfoLabel)
        addSubview(dateLabel)
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(75)
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(posterImageView.snp.trailing).inset(20)
        }
        
        directorNameLabel.snp.makeConstraints {
            $0.top.equalTo(movieNameLabel.snp.bottom).inset(5)
            $0.leading.equalTo(posterImageView.snp.trailing).inset(20)
            $0.trailing.equalToSuperview()
        }
        
        movieInfoLabel.snp.makeConstraints {
            $0.top.equalTo(directorNameLabel.snp.bottom).inset(5)
            $0.leading.equalTo(directorNameLabel.snp.trailing).inset(20)
            $0.trailing.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(movieInfoLabel.snp.bottom).inset(5)
            $0.leading.equalTo(posterImageView.snp.trailing).inset(20)
            $0.trailing.equalToSuperview()
        }
    }
    
    private func setup() {
        contentView.backgroundColor = .white
        movieNameLabel.text = "메멘토"
        directorNameLabel.text = "크리스토퍼 놀란"
        movieInfoLabel.text = "미국 | 미스터리, 범죄 | 2000"
    }
    
    private func configureShadow() {
        layer.shadowRadius = 3
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
    
    private func configureCornerRadius() {
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
    }
}

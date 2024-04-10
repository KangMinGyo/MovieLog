//
//  LoadingCell.swift
//  MovieLog
//
//  Created by KangMingyo on 4/10/24.
//

import UIKit
import SnapKit
import Then

class LoadingCell: UICollectionViewCell {
    
    static let identifier = "LoadingCell"
    
    // MARK: - UI Components
    
    let posterImageView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let movieNameLabel = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let directorNameLabel = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let movieInfoLabel = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let dateLabel = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure
    private func setupConstraints() {
        addSubview(posterImageView)
        addSubview(movieNameLabel)
        addSubview(directorNameLabel)
        addSubview(movieInfoLabel)
        addSubview(dateLabel)
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(0).inset(20)
            $0.width.equalTo(75)
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(0).inset(20)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.height.equalTo(30)
        }
        
        directorNameLabel.snp.makeConstraints {
            $0.top.equalTo(movieNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(0).inset(20)
            $0.height.equalTo(15)
        }
        
        movieInfoLabel.snp.makeConstraints {
            $0.top.equalTo(directorNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(0).inset(20)
            $0.height.equalTo(15)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(0).inset(20)
            $0.bottom.equalTo(self.snp.bottom).offset(-20)
            $0.height.equalTo(15)
        }
    }
}

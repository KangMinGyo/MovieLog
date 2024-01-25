//
//  CalendarCell.swift
//  MovieLog
//
//  Created by KangMingyo on 1/25/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class CalendarCell: UICollectionViewCell {
    
    static let identifier = "HomeCell"
    
    // MARK: - UI Components
    let posterImageView = UIImageView().then {
        $0.image = UIImage(named: "Poster")
    }

    let movieNameLabel = UILabel().then {
        $0.text = "영화 제목"
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        setupConstraints()
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
    
    //MARK: - Configure
    
    private func setupConstraints() {
        addSubview(posterImageView)
        addSubview(movieNameLabel)
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(0).inset(20)
            $0.width.equalTo(75)
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(0).inset(20)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
        }
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
    
    func setup(with data: Review) {
        posterImageView.image = UIImage(named: "Poster")
        let url = URL(string: "https://image.tmdb.org/t/p/original\(data.posterURL)")
        posterImageView.kf.setImage(with: url)
        movieNameLabel.text = data.title
    }
}

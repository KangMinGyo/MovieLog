//
//  BoxOfficeCell.swift
//  MovieLog
//
//  Created by KangMingyo on 4/3/24.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class BoxOfficeCell: UICollectionViewCell {
    
    static let identifier = "BoxOfficeCell"
    
    // MARK: - UI Components
    let posterImageView = UIImageView().then {
        $0.image = UIImage(named: "Poster")
    }

    let movieNameLabel = UILabel().then {
        $0.text = "영화 제목"
        $0.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.numberOfLines = 0
    }
    
    let openDateLabel = UILabel().then {
        $0.text = "2022-07-19"
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let boxOfficeRank = UILabel().then {
        $0.text = "1"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let boxOfficeLabel = UILabel().then {
        $0.text = "박스오피스"
        $0.font = .systemFont(ofSize: 15)
    }
    
    let boxOfficeRankStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
    }
    
    let rankInten = UILabel().then {
        $0.text = "-"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let rankIntenLabel = UILabel().then {
        $0.text = "전일대비"
        $0.font = .systemFont(ofSize: 15)
    }
    
    let rankIntenStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
    }
    
    let audiAcc = UILabel().then {
        $0.text = "353만"
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    let audiAccLabel = UILabel().then {
        $0.text = "누적관객수"
        $0.font = .systemFont(ofSize: 15)
    }
    
    let audiAccStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.alignment = .center
    }
    
    let stackView =  UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .white
        
        setupConstraints()
        configureShadow()
        configureCornerRadius()
        configureStackView()
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
        addSubview(openDateLabel)
        addSubview(lineView)
        addSubview(stackView)
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalTo(0).inset(20)
            $0.width.equalTo(75)
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(0).inset(20)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
        }
        
        openDateLabel.snp.makeConstraints {
            $0.top.equalTo(movieNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(openDateLabel.snp.bottom).offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            $0.height.equalTo(1)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(10)
        }
    }
    
    func configureStackView() {
        [boxOfficeRank, boxOfficeLabel].forEach {
            self.boxOfficeRankStackView.addArrangedSubview($0)
        }
        
        [audiAcc, audiAccLabel].forEach {
            self.audiAccStackView.addArrangedSubview($0)
        }
        
        [rankInten, rankIntenLabel].forEach {
            self.rankIntenStackView.addArrangedSubview($0)
        }
        
        [boxOfficeRankStackView, rankIntenStackView, audiAccStackView].forEach {
            self.stackView.addArrangedSubview($0)
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
    
    func configure(_ data: DailyBoxOfficeList) {
        if let posterPath = data.posterPath {
            let urlString = "https://image.tmdb.org/t/p/original\(posterPath)"
            if let url = URL(string: urlString) {
                posterImageView.kf.setImage(with: url)
            }
        }
        movieNameLabel.text = data.movieNm
        openDateLabel.text = data.openDt
        boxOfficeRank.text = data.rank
        rankInten.text = data.rankInten
        audiAcc.text = data.audiAcc
//        rankInten.text = rankIntenCal(data.rankInten)
//        audiAcc.text = audiAccCal(data.audiAcc)
    }
}

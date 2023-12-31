//
//  SearchCell.swift
//  MovieLog
//
//  Created by KangMingyo on 12/21/23.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {
    
    static let identifier = "SearchCell"
    
    // MARK: - UI Components
    let movieNameLabel = UILabel().then {
        $0.text = "영화제목"
    }
    
    let directorLabel = UILabel().then {
        $0.text = "영화감독"
        $0.textColor = .systemGray2
    }
    
    let movieInfoLabel = UILabel().then {
        $0.text = "미국 • 미스터리, 범죄 • 2000"
        $0.textColor = .systemGray2
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        setupStackView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(0).inset(20)
            $0.centerY.equalTo(snp.centerY)
        }
    }
    
    func setupStackView() {
        [movieNameLabel, directorLabel, movieInfoLabel].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
    
    func setup(with data: MovieList) {
        movieNameLabel.text = data.movieNm
        directorLabel.text = data.directors.first?.peopleNm ?? "-"
        movieInfoLabel.text = data.movieInfo
    }
}

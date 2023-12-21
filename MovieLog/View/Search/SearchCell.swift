//
//  SearchCell.swift
//  MovieLog
//
//  Created by KangMingyo on 12/21/23.
//

import UIKit

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
        $0.text = "미국 | 미스터리, 범죄 | 2000"
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
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupStackView() {
        [movieNameLabel, directorLabel, movieInfoLabel].forEach {
            self.stackView.addArrangedSubview($0)
        }
    }
}

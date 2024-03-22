//
//  MovieInputFormHeaderView.swift
//  MovieLog
//
//  Created by KangMingyo on 1/3/24.
//

import UIKit
import SnapKit
import Then

final class MovieInputFormHeaderView: UIView {
    
    // MARK: - UI Components
    lazy var titleLabel = UILabel().then {
        $0.text = "영화정보추가"
        $0.textColor = UIColor(named: "MainColor")
        $0.font = .systemFont(ofSize: 38, weight: .bold)
    }
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    private func setupConstraints() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(self.frame.width)
        }
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MovieInputFormHeaderViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = MovieInputFormHeaderView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

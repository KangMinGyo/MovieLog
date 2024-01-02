//
//  MovieRegistrationView.swift
//  MovieLog
//
//  Created by KangMingyo on 12/30/23.
//

import UIKit
import SnapKit

class MovieRegistrationView: UIView {
    
    // MARK: - UI Components
    lazy var label = UILabel().then {
        $0.text = "찾는 영화가 없으신가요?"
        $0.font = .systemFont(ofSize: 18)
    }
    
    lazy var button = UIButton().then {
        $0.setTitle("영화정보 추가하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(named: "MainColor")
        $0.layer.cornerRadius = 25
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        backgroundColor = .systemGray6
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    func setupConstraints() {
        self.addSubview(label)
        self.addSubview(button)
        
        label.snp.makeConstraints {
            $0.top.equalTo(0).offset(20)
            $0.centerX.equalTo(snp.centerX)
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.centerX.equalTo(snp.centerX)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
    }
}

#if canImport(SwiftUI) && DEBUG

import SwiftUI

struct MyMovieRegistrationViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = MovieRegistrationView()
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif

//
//  CustomLikeButton.swift
//  MovieLog
//
//  Created by KangMingyo on 12/22/23.
//

import UIKit

class CustomLikeButton: UIButton {
    enum State {
        case like
        case hate
    }
    
    init(title: String, state: State) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        self.backgroundColor = .systemGray6
        
        let titleColor: UIColor = .black
        self.setTitleColor(titleColor, for: .normal)
        
        switch state {
        case .like:
            self.titleLabel?.font = .systemFont(ofSize: 18,  weight: .medium)
        case .hate:
            self.titleLabel?.font = .systemFont(ofSize: 18,  weight: .medium)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

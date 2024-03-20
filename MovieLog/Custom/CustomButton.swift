//
//  CustomButton.swift
//  MovieLog
//
//  Created by KangMingyo on 11/23/23.
//

import UIKit
import MovieLog_Resource

class CustomButton: UIButton {
    enum FontSize {
        case big
        case med
        case small
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        self.backgroundColor = hasBackground ? R.Color.green : .clear
        
        let titleColor: UIColor = hasBackground ? .white : .systemGray
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18,  weight: .medium)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

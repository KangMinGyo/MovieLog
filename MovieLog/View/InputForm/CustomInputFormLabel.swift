//
//  CustomInputFormLabel.swift
//  MovieLog
//
//  Created by KangMingyo on 1/3/24.
//

import UIKit

class CustomInputFormLabel: UILabel {

    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

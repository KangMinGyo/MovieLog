//
//  CustomStackView.swift
//  MovieLog
//
//  Created by KangMingyo on 12/2/23.
//

import UIKit

class CustomStackView: UIStackView {
    init() {
        super.init(frame: .zero)
        self.axis = .vertical
        self.spacing = 0
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

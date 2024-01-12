//
//  CustomPosterButton.swift
//  MovieLog
//
//  Created by KangMingyo on 1/12/24.
//

import UIKit

class CustomPosterButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        backgroundColor = .systemGray6
        self.setImage(UIImage(systemName: "plus"), for: .normal)
    }
}

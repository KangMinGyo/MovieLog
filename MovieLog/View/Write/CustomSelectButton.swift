//
//  CustomSelectButton.swift
//  MovieLog
//
//  Created by KangMingyo on 12/23/23.
//

import UIKit

class CustomSelectButton: UIButton {
    let imageSize = CGSize(width: 50, height: 50)
    
    enum Select {
        case acting
        case direct
        case ost
        case visual
        case story
    }
    
    init(select: Select) {
        super.init(frame: .zero)
        setupButton(select: select)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(select: Select) {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
        
        switch select {
        case .acting:
            let image = UIImage(named: "Acting")?.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
        case .direct:
            let image = UIImage(named: "direct")?.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
        case .ost:
            let image = UIImage(named: "music")?.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
        case .visual:
            let image = UIImage(named: "video")?.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
        case .story:
            let image = UIImage(named: "story")?.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
        }
    }
}

//
//  CustomSelectButton.swift
//  MovieLog
//
//  Created by KangMingyo on 12/23/23.
//

import UIKit
import MovieLog_Resource

class CustomSelectButton: UIButton {
    let imageSize = CGSize(width: 50, height: 50)
    
    enum Select {
        case acting
        case direct
        case ost
        case video
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
            let image = R.Image.acting.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
            self.tag = 0
        case .direct:
            let image = R.Image.direct.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
            self.tag = 1
        case .ost:
            let image = R.Image.music.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
            self.tag = 2
        case .video:
            let image = R.Image.video.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
            self.tag = 3
        case .story:
            let image = R.Image.story.resize(targetSize: imageSize)
            self.setImage(image, for: .normal)
            self.tag = 4
        }
    }
}

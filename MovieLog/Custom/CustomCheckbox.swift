//
//  CustomCheckbox.swift
//  MovieLog
//
//  Created by KangMingyo on 12/5/23.
//

import UIKit

class CustomCheckbox: UIButton {
    let checkedImage = UIImage(systemName: "checkmark.square.fill")
    let uncheckedImage = UIImage(systemName: "square")
    
    var isChecked: Bool = false {
        didSet {
            if isChecked {
                setImage(checkedImage, for: .normal)
            } else {
                setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(.systemGray, for: .normal)
        self.tintColor = UIColor(named: "MainColor")
        addTarget(self, action:#selector(buttonClicked), for: .touchUpInside)
        isChecked = false
        setImage(uncheckedImage, for: .normal)
        
        var config = UIButton.Configuration.plain()
        config.imagePadding = 10 // 이미지 패딩 조정
        
        // 버튼의 이미지와 텍스트 간격을 조정
        config.imagePlacement = .leading
        config.titlePadding = 10 // 텍스트 패딩 조정

        self.configuration = config
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}

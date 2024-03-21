//
//  R+Image.swift
//  MovieLog-Resource
//
//  Created by KangMingyo on 3/21/24.
//

import UIKit

public extension R {
    enum Image { }
}

public extension R.Image {
    static var btnBack: UIImage { .load(name: "btn_back") }
    static var btnClose: UIImage { .load(name: "btn_close") }
    static var btnDelete: UIImage { .load(name: "btn_delete") }
    static var btnLocation: UIImage { .load(name: "btn_location") }
    static var btnSearch: UIImage { .load(name: "btn_search") }
    static var btnSetting: UIImage { .load(name: "btn_setting") }
    
    static var imgLogo: UIImage { .load(name: "img_logo") }
    
    static var imgSocarLogo: UIImage { .load(name: "socar_logo")}
    static var imgGreencarLogo: UIImage { .load(name: "greencar_logo")}
}

extension UIImage {
    static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: R.bundle, compatibleWith: nil) else {
            assert(false, "\(name) 이미지 로드 실패")
            return UIImage()
        }
        return image
    }
}

//
//  R.swift
//  MovieLog
//
//  Created by KangMingyo on 3/20/24.
//  리소스들을 프레임워크로 만드는 코드

import Foundation

public class R {
    static let bundle = Bundle(for: R.self)
}

//public class R {
//    static let bundle = Bundle(for: R.self)
//}
//
//public extension R {
//    enum Color { }
//}
//
//public extension R.Color {
//    static var gray: UIColor { .load(name: "gray") }
//    static var green: UIColor { .load(name: "green") }
//    static var red: UIColor { .load(name: "red") }
//}
//
//extension UIColor {
//    static func load(name: String) -> UIColor {
//        guard let color = UIColor(named: name, in: R.bundle, compatibleWith: nil) else {
//            assert(false, "\(name) 컬러 로드 실패")
//            return UIColor()
//        }
//        return color
//    }
//}

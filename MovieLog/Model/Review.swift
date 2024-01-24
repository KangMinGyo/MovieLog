//
//  Review.swift
//  MovieLog
//
//  Created by KangMingyo on 1/6/24.
//

import UIKit

class Review {
    var uid: String = ""
    var posterURL: String = ""
    var title: String = ""
    var director: String = ""
    var movieInfo: String = ""
    var date: Date?
    var how: String = ""
    var what = [Bool]()
    var review: String = ""
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.posterURL = data["posterURL"] as? String ?? ""
        self.title = data["title"] as? String ?? ""
        self.director = data["director"] as? String ?? ""
        self.movieInfo = data["movieInfo"] as? String ?? ""
        if let dateString = data["date"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "작성일: yy.MM.dd a hh:mm"
            dateFormatter.locale = Locale(identifier:"ko_KR")
            self.date = dateFormatter.date(from: dateString)
        }
        self.how = data["how"] as? String ?? ""
        self.what = data["what"] as? [Bool] ?? []
        self.review = data["review"] as? String ?? ""
    }
}

//class Review {
//    var uid: String = ""
//    var posterURL: String = ""
//    var title: String = ""
//    var director: String = ""
//    var movieInfo: String = ""
//    var date: String = ""
//    var how: String = ""
//    var what = [Bool]()
//    var review: String = ""
//    
//    init(data: [String: Any]) {
//        self.uid = data["uid"] as? String ?? ""
//        self.posterURL = data["posterURL"] as? String ?? ""
//        self.title = data["title"] as? String ?? ""
//        self.director = data["director"] as? String ?? ""
//        self.movieInfo = data["movieInfo"] as? String ?? ""
//        self.date = data["date"] as? String ?? ""
//        self.how = data["how"] as? String ?? ""
//        self.what = data["what"] as? [Bool] ?? []
//        self.review = data["review"] as? String ?? ""
//    }
//}

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
//    var posterImage = UIImage()
    var title: String = ""
    var director: String = ""
    var movieInfo: String = ""
    var date: String = ""
    var how: String = ""
    var what = [Bool]()
    var review: String = ""
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.posterURL = data["imageURL"] as? String ?? ""
//        self.posterImage = data["posterImage"] as? UIImage ?? UIImage(named: "Poster")!
        self.title = data["title"] as? String ?? ""
        self.director = data["director"] as? String ?? ""
        self.movieInfo = data["movieInfo"] as? String ?? ""
        self.date = data["date"] as? String ?? ""
        self.how = data["how"] as? String ?? ""
        self.what = data["what"] as? [Bool] ?? []
        self.review = data["review"] as? String ?? ""
    }
}

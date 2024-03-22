//
//  ReviewDetailViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 3/21/24.
//

import Foundation
import Combine

class ReviewDetailViewModel: ObservableObject {
    
    let tag = ["연기", "연출", "OST", "스토리", "영상미"]
    var goodPointValue = String()
    @Published var review: Review
    
    init(review: Review) {
        self.review = review
    }

    func goodPoint() -> String {
        for i in 0..<5 {
            if review.what[i] == true {
                goodPointValue.append("#\(tag[i]) ")
            }
        }
        return goodPointValue
    }
}

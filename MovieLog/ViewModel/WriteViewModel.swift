//
//  WriteViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 1/5/24.
//

import UIKit
import Combine

class WriteViewModel: ObservableObject {
    var searchData: MovieList?
    var howData: String?
    var whatData: [Bool]?
    var reviewText: String?
    
    var dateString: String? {
        let date =  Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "작성일: yy.MM.dd a hh:mm"
        dateFormatter.locale = Locale(identifier:"ko_KR")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func uploadReview() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let reviewData = ["uid": uid,
                         "imageURL": String(),
                          "title": searchData?.movieNm,
                          "director": searchData?.directors.first?.peopleNm,
                          "movieInfo": searchData?.movieInfo,
                         "date": dateString,
                         "how": howData,
                         "what": whatData,
                         "review": reviewText] as [String : Any]
        
        FirebaseManager.shared.fireStore.collection("review")
            .document().setData(reviewData) { err in
                if let err = err {
                    print(err)
                    return
                }
                print("Success")
            }
    }
}

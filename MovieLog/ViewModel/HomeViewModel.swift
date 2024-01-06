//
//  HomeViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 1/6/24.
//

import Foundation

class HomeViewModel {
    
    func fetchReview(forUid uid: String, completion: @escaping([Review]) -> Void) {
        FirebaseManager.shared.fireStore
            .collection("review")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, err in
                guard let documents = snapshot?.documents else { return }
                if let err = err {
                    print("Error fetching reviews: \(err.localizedDescription)")
                    return
                }
                
                for document in documents {
                    let reviewData = document.data()
                    print("Review Data ->>: \(reviewData)")
                }
            }
    }
}

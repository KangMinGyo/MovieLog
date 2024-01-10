//
//  HomeViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 1/6/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    let service = ReviewService()
    @Published var reviews = [Review]()
    var subscriptions = Set<AnyCancellable>()
    
    func fetchReviews(completion: @escaping([Review]) -> Void) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.fireStore
            .collection("review")
            .document(uid)
            .collection("review")
            .getDocuments { snapshot, err in
                guard let documents = snapshot?.documents else { return }
                if let err = err {
                    print("Error fetching reviews: \(err.localizedDescription)")
                    return
                }
                
                for document in documents {
                    let reviewData = document.data()
                    self.reviews.append(Review(data: reviewData))
                    print("Review Data ->>: \(self.reviews)")
                }
            }
    }
}
    

//
//  HomeViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 1/6/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    //
    init(selectedItem: Review? = nil) {
        self.selectedItem = CurrentValueSubject(selectedItem)
    }

    var reviewsSubject = PassthroughSubject<[Review], Error>()
    let selectedItem: CurrentValueSubject<Review?, Never> //
    
    @Published var reviews = [Review]()
    var subscriptions = Set<AnyCancellable>()
    
    func fetchReviews() {
        reviews = [Review]()
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }

        FirebaseManager.shared.fireStore
            .collection("review")
            .document(uid)
            .collection("review")
            .order(by: "date", descending: true)
            .getDocuments { [weak self] snapshot, err in
                guard let self = self else { return }
                guard let documents = snapshot?.documents else { return }
                if let err = err {
                    print("Error fetching reviews: \(err.localizedDescription)")
                    return
                }
                
                for document in documents {
                    let reviewData = document.data()
                    self.reviews.append(Review(data: reviewData))
                }
                
                self.reviewsSubject.send(reviews)
            }
    }
    
    //
    func didSelect(at indexPath: IndexPath) {
        let review = reviews[indexPath.item]
        selectedItem.send(review)
    }
}
    

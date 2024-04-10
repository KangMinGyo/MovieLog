//
//  HomeViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 1/6/24.
//

import Foundation
import Combine
import Firebase

class HomeViewModel: ObservableObject {
    
    init(selectedItem: Review? = nil) {
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
    @Published var reviews = [Review]()
    @Published var isLoading = Bool()
    var subscriptions = Set<AnyCancellable>()

    var reviewsSubject = PassthroughSubject<[Review], Error>()
    let selectedItem: CurrentValueSubject<Review?, Never> //
    
    func fetchReviews() {
        reviews = [Review]()
        isLoading = true // 로딩 시작
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // 1초 후에 실행
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
                    self.isLoading = false // 로딩 완료
                }
        }
    }

    func didSelect(at indexPath: IndexPath) {
        let review = reviews[indexPath.item]
        selectedItem.send(review)
    }
}


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
    
    func findReviewToDelete(title: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let query = FirebaseManager.shared.fireStore
            .collection("review")
            .document(uid)
            .collection("review")
            .whereField("title", isEqualTo: title)
        
        query.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                guard let documents = querySnapshot?.documents else {
                    print("No documents found.")
                    return
                }
                
                for document in documents {
                    let reviewID = document.documentID
                    print("Found review to delete with ID: \(reviewID)")
                    self.deleteReview(reviewID: reviewID)
                }
            }
        }
    }
    
    func deleteReview(reviewID: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let query = FirebaseManager.shared.fireStore
            .collection("review")
            .document(uid)
            .collection("review")
        
        query.document(reviewID).delete()
            print("삭제 완료")
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

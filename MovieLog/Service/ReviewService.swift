//
//  ReviewService.swift
//  MovieLog
//
//  Created by KangMingyo on 1/6/24.
//

//import Combine

//struct ReviewService {
//    func fetchReview(uid: String) -> AnyPublisher<[Review], Error> {
//        return Future<[Review], Error> { promise in
//            FirebaseManager.shared.fireStore
//                .collection("review")
//                .document(uid)
//                .collection("review")
//                .getDocuments { snapshot, err in
//                    guard let documents = snapshot?.documents else { return }
//                    for document in documents {
//                        let reviewData = document.data()
//                    }
//                    promise(.success(reviewData)) // 완성된 리뷰 배열을 성공적으로 반환합니다.
//                }
//        }.eraseToAnyPublisher()
//    }
//}

import Foundation

struct ReviewService {
    func fetchReview(forUid uid: String, completion: @escaping([Review]) -> Void) {
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
                    print("Review Data ->>: \(reviewData)")
                }
            }
    }
}

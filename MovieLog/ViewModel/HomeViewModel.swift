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
    @Published var review = [Review]()
    
    func fetchPost() {
        print("*fetchPost*")
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        service.fetchReview(forUid: uid, completion: { data in
            self.review = data
        })
    }
}

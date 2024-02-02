//
//  ChartViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 2/1/24.
//

import Foundation

class ChartViewModel: ObservableObject {
    var reviews = [Review]()
    
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
                    calculateWeeklyStats(reviews: reviews)
                }
            }
    }
    
    func calculateWeeklyStats(reviews: [Review]) -> [Int] {
        var weeklyStats = [Int](repeating: 0, count: 7)
        print("review: \(reviews.count)")
        for review in reviews {
            print("date: \(review.date)")
            if let date = review.date {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.weekday], from: date)
                if let weekday = components.weekday {
                    weeklyStats[weekday - 1] += 1
                }
            }
        }
        print("weekly : \(weeklyStats)")
        return weeklyStats
    }
}

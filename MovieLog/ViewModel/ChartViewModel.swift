//
//  ChartViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 2/1/24.
//

import Foundation

class ChartViewModel: ObservableObject {
    var reviews = [Review]()
    var reviewCount: [Double] = [0, 0, 0, 0, 0, 0, 0]
    
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
                    datesInPastWeek(reviews: reviews)
                }
            }
    }
    
    func calculateWeeklyStats(reviews: [Review]) -> [Double] {
        for review in reviews {
            print("date: \(review.date)")
            if let date = review.date {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.weekday], from: date)
                if let weekday = components.weekday {
                    reviewCount[weekday - 1] += 1
                }
            }
        }
        print("weekly : \(reviewCount)")
        return reviewCount
    }
    
    func datesInPastWeek(reviews: [Review]) {
        let currentDate = Date()
        let calendar = Calendar.current
        var datesInPastWeek: [Date] = []
        var index = 0

        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: currentDate) {
                datesInPastWeek.append(date)
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for date in datesInPastWeek {
            let formattedDate = dateFormatter.string(from: date)
            for review in reviews {
                if let reviewDate = review.date {
                    let formattedReviewDate = dateFormatter.string(from: reviewDate)
                    print("formattedReviewDate: \(formattedReviewDate)")
                    if formattedReviewDate == formattedDate {
                        print("\(formattedReviewDate), \(formattedDate) 일치")
                        reviewCount[index] += 1
                    }
                }
            }
            index += 1
            print("일주일 전까지의 날짜: \(formattedDate)")
        }
        
        // 결과 출력
        for (index, date) in datesInPastWeek.enumerated() {
            let formattedDate = dateFormatter.string(from: date)
            print("날짜: \(formattedDate), 리뷰 수: \(reviewCount[index])")
        }
    }
}

//
//  ChartViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 2/1/24.
//

import Foundation

class ChartViewModel: ObservableObject {
    var reviews = [Review]()
    var reviewCount: [Double] = [1, 0, 0, 0, 0, 0, 0]
    
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
    
    func calculateWeeklyStats(reviews: [Review]) -> [Double] {
        print("review: \(reviews.count)")
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
    
    func datesInPastWeek() {
        // 현재 날짜 얻기
        let currentDate = Date()

        // Calendar 객체 생성
        let calendar = Calendar.current

        // 현재 날짜로부터 일주일 전까지의 날짜 얻기
        var datesInPastWeek: [Date] = []

        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: -i, to: currentDate) {
                datesInPastWeek.append(date)
            }
        }

        // 얻은 날짜를 문자열로 출력 또는 다른 작업 수행
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for date in datesInPastWeek {
            let formattedDate = dateFormatter.string(from: date)
            print("일주일 전까지의 날짜: \(formattedDate)")
        }
    }
}

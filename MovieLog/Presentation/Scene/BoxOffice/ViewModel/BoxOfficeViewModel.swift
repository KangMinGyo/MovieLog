//
//  BoxOfficeViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 4/4/24.
//

import Foundation
import Combine

class BoxOfficeViewModel: ObservableObject {
    
    let networkManager = NetworkManager()
    
    @Published var boxOfficeData = [DailyBoxOfficeList]()
    var posterUpdatePublisher = PassthroughSubject<Void, Never>()

    func configureBoxOffice(date: String) {
        boxOfficeData = [DailyBoxOfficeList]()
        let url = EndPoints.makeBoxOfficeApi(
            key: "60c9b995596ead85ff6e59a8d3725e72",
            date: date
        )
        networkManager.fetchData(for: url,
                                 dataType: BoxOffice.self) { result in
            switch result {
            case .success(let data):
                print("BoxOffice Data -->\(data)")
                self.boxOfficeData.append(contentsOf: data.boxOfficeResult.dailyBoxOfficeList)
                self.getBoxOfficeMoviePoster()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // Poster 이미지 url 가져오기
    func getMoviePoster(title: String, completion: @escaping (String?) -> Void) {
        let url = EndPoints.makeMoviePosterApi(
            key: "ab318418ee513b352deb4c9ab21f7ed7",
            title: title
        )
        networkManager.fetchData(for: url,
                                 dataType: Poster.self) { result in
            switch result {
            case .success(let data):
                if let posterPath = data.results.first?.posterPath {
                    completion(posterPath)
                } else {
                    // 포스터 URL이 없는 경우 빈 문자열을 추가
                    completion(nil)
                }
            case .failure(let err):
                print(err)
            }
        }
    }

    func getBoxOfficeMoviePoster() {
        let dispatchGroup = DispatchGroup() // DispatchGroup 생성
        
        for (index, movie) in boxOfficeData.enumerated() {
            dispatchGroup.enter() // DispatchGroup에 작업 시작을 알림
            
            getMoviePoster(title: movie.movieNm) { posterPath in
                self.boxOfficeData[index].posterPath = posterPath
                
                dispatchGroup.leave() // DispatchGroup에 작업 완료를 알림
            }
        }
        // 모든 작업이 완료될 때까지 기다림
        dispatchGroup.notify(queue: .main) {
            print("All poster fetching tasks have completed")
            print("\(self.boxOfficeData)")
            self.posterUpdatePublisher.send()
        }
    }
}

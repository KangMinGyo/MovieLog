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
    var posterData = [Results]()
    var posterUrl = [String]()

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
    func getMoviePoster(title: String, completion: @escaping () -> Void) {
        posterData = [Results]()
        let url = EndPoints.makeMoviePosterApi(
            key: "ab318418ee513b352deb4c9ab21f7ed7",
            title: title
        )
        networkManager.fetchData(for: url,
                                 dataType: Poster.self) { result in
            switch result {
            case .success(let data):
                self.posterData.append(contentsOf: data.results)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getBoxOfficeMoviePoster() {
        for i in 0..<boxOfficeData.count {
            let name = boxOfficeData[i].movieNm
            getMoviePoster(title: name) { [self] in
                posterUrl.append(posterData.first?.posterPath ?? "")
                posterData = [Results]()
            }
        }
    }
}

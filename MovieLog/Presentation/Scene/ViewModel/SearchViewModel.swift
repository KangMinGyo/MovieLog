//
//  SearchViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 12/29/23.
//

import UIKit
import Combine

class SearchViewModel: ObservableObject {
    
    let networkManager = NetworkManager()
    var subscriptions = Set<AnyCancellable>()
    
    @Published var searchData = [MovieList]()
    
    func configureMovieSearch(title: String) {
        searchData = [MovieList]()
        let url = EndPoints.makeMovieSearchApi(
            key: "60c9b995596ead85ff6e59a8d3725e72",
            title: title
        )
        networkManager.fetchData(for: url,
                                 dataType: Search.self) { result in
            switch result {
            case .success(let data):
                print("-->\(data)")
                self.searchData.append(contentsOf: data.movieListResult.movieList)
            case .failure(let err):
                print(err)
            }
        }
    }
}


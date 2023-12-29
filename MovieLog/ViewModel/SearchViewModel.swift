//
//  SearchViewModel.swift
//  MovieLog
//
//  Created by KangMingyo on 12/29/23.
//

import UIKit
import Combine

class SearchViewModel {
    let networkManager = NetworkManager()
    
    func configureMovieSearch(title: String) {
        let url = EndPoints.makeMovieSearchApi(
            key: "60c9b995596ead85ff6e59a8d3725e72",
            title: title
        )
        
        networkManager.fetchData(for: url,
                                 dataType: Search.self) { result in
            switch result {
            case .success(let data):
                print("-->\(data)")
            case .failure(let err):
                print(err)
            }
        }
    }
}


//
//  Search.swift
//  MovieLog
//
//  Created by KangMingyo on 12/29/23.
//

import Foundation

struct Search: Decodable {
    let movieListResult : MovieListResult
}

struct MovieListResult: Decodable {
    let movieList: [MovieList]
}

struct MovieList: Decodable {
    let movieNm: String
    let prdtYear: String
    let nationAlt: String
    let genreAlt: String
    let directors: [Director]
    var movieInfo: String {
        return "\(nationAlt) • \(genreAlt) • \(prdtYear)"
    }
}

struct Director: Decodable {
    let peopleNm: String
}

extension Search {
    static let sampleData: [MovieList] = [
        MovieList(movieNm: "범죄도시4",
                  prdtYear: "2022",
                  nationAlt: "한국",
                  genreAlt: "액션,범죄",
                  directors: [director])
    ]
    static let director = Director(peopleNm: "John Doe")
}

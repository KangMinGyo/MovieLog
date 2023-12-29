//
//  APIComponents.swift
//  MovieLog
//
//  Created by KangMingyo on 12/29/23.
//

import Foundation

enum Query {
    case searchMovie(title: String)
    case boxOffice(targetDt: String)
    case movieInfo(code: String)
    
    var dictionary: [String: String] {
        switch self {
        case .searchMovie(title: let title):
            return ["movieNm": title]
        case .boxOffice(targetDt: let date):
            return ["targetDt": date]
        case .movieInfo(code: let code):
            return ["movieCd": code]
        }
    }
}

enum Key {
    case kobisKey(key: String)
    
    var dictionary: [String: String] {
        switch self {
        case .kobisKey(key: let key):
            return ["key": key]
        }
    }
}

enum BaseURL: String {
    case movieSearch = "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json"
    case movieInfo = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
}

enum APIKey: String {
    case kobisKey = "60c9b995596ead85ff6e59a8d3725e72"
}

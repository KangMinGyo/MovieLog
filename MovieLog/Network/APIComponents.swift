//
//  APIComponents.swift
//  MovieLog
//
//  Created by KangMingyo on 12/29/23.
//

import Foundation

enum MovieQuery {
    case searchMovie(title: String)
    case moviePoster(query: String)
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
        case .moviePoster(query: let title):
            return ["query": title]
        }
    }
}

enum Key {
    case kobisKey(key: String)
    case tbdmKey(key: String)
    
    var dictionary: [String: String] {
        switch self {
        case .kobisKey(key: let key):
            return ["key": key]
        case .tbdmKey(key: let key):
            return ["api_key": key]
        }
    }
}

enum BaseURL: String {
    case movieSearch = "https://kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieList.json"
    case moviePoster = "https://api.themoviedb.org/3/search/movie?language=ko&page=1&include_adult=false&region=KR"
    case movieInfo = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    case poster = "https://image.tmdb.org/t/p/original"
    case boxOffice = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
}

enum APIKey: String {
    case kobisKey = "60c9b995596ead85ff6e59a8d3725e72"
    case tmdbKey = "ab318418ee513b352deb4c9ab21f7ed7"
}

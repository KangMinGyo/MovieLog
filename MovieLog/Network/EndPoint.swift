//
//  EndPoint.swift
//  MovieLog
//
//  Created by KangMingyo on 12/29/23.
//

import Foundation

class EndPoint: APIRequest {
    var baseURL: BaseURL
    var key: Key
    var method: String
    var query: MovieQuery
    
    init(
        baseURL: BaseURL,
        key: Key,
        method: String = "GET",
        query: MovieQuery
    ) {
        self.baseURL = baseURL
        self.key = key
        self.method = method
        self.query = query
    }
}

struct EndPoints {
    static func makeMovieSearchApi(key: String, title: String) -> APIRequest {
        return EndPoint(baseURL: .movieSearch, key: .kobisKey(key: key), query: .searchMovie(title: title))
    }
    
    static func makeMoviePosterApi(key: String, title: String) -> APIRequest {
        return EndPoint(baseURL: .moviePoster, key: .tbdmKey(key: key), query: .moviePoster(query: title))
    }
    
    static func makeBoxOfficeApi(key: String, date: String) -> APIRequest {
        return EndPoint(baseURL: .boxOffice, key: .kobisKey(key: key), query: .boxOffice(targetDt: date))
    }
//    
//    static func makeDetailMovieApi(key: String, code: String) -> APIRequest {
//        return EndPoint(baseURL: .movieInfo, key: .boxOffice(key: key), query: .movieInfo(code: code))
//    }
}

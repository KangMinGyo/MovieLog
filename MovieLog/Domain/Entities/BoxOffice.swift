//
//  BoxOffice.swift
//  MovieLog
//
//  Created by KangMingyo on 4/4/24.
//

import Foundation

struct BoxOffice: Codable, Hashable {
    let boxOfficeResult : BoxOfficeResult
}

struct BoxOfficeResult: Codable, Hashable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable, Hashable {
    let rank: String
    let rankInten: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let movieCd: String
}

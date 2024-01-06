//
//  Poster.swift
//  MovieLog
//
//  Created by KangMingyo on 1/6/24.
//

import Foundation

struct Poster: Codable {
    let results : [Results]
}

struct Results: Codable {
    let posterPath : String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}

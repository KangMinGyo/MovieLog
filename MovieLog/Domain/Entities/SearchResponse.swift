//
//  SearchResponse.swift
//  MovieLog
//
//  Created by KangMingyo on 12/29/23.
//

import Foundation

//struct SearchResponse: Decodable {
//    var items: [Search]
//}

struct SearchResult: Hashable, Identifiable, Decodable {
    
    var id: Int64
    var login: String
    var avatarUrl: URL
    var htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}


struct SearchUserResponse: Decodable {
    var items: [SearchResult]
}

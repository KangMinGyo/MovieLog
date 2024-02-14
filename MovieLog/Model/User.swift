//
//  User.swift
//  MovieLog
//
//  Created by KangMingyo on 11/24/23.
//

import Foundation

struct User:  Codable, Hashable {
    let email: String
    let password: String
}

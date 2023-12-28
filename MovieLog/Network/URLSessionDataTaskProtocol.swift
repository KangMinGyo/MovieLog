//
//  URLSessionDataTaskProtocol.swift
//  MovieLog
//
//  Created by KangMingyo on 12/28/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}

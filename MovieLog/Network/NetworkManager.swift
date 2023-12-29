//
//  NetworkManager.swift
//  MovieLog
//
//  Created by KangMingyo on 12/28/23.
//

import Foundation

enum NetworkError: Error {
    case failToParse
    case invalid
}

final class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(for url: APIRequest,
                                 dataType: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let request = url.configureRequest() else {
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completion(.failure(error!))
            }
            if let data = data,
               let response = response as? HTTPURLResponse,
               200..<400 ~= response.statusCode {
                do {
                    let data = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(NetworkError.failToParse))
                }
            } else {
                completion(.failure(NetworkError.invalid))
            }
        }
        .resume()
    }
}

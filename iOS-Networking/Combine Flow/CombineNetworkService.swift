//
//  CombineNetworkService.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
import Combine

class CombineNetworkService {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        let urlRequest = URLRequest(url: url)
        return self.session
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response in

                let statusCode = (response as? HTTPURLResponse)?.statusCode
                guard
                    let code = statusCode,
                    (200..<300) ~= code
                else {
                    throw NetworkError.serverError(statusCode: statusCode)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

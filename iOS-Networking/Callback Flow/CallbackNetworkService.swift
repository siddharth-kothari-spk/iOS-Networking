//
//  CallbackNetworkService.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation


class CallbackNetworkService {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get<T: Decodable>(url: URL, callback: @escaping (Result<T, Error>) -> ()) {
        let urlRequest = URLRequest(url: url)
        self.session.dataTask(with: urlRequest) { data, response, error in
            // 1. Network Error Handling
            guard error == nil else {
                callback(.failure(error!))
                return
            }
            
            // 2. Server Error Handling
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            guard
                let code = statusCode,
                (200..<300) ~= code
            else {
                callback(.failure(NetworkError.serverError(statusCode: statusCode)))
                return
            }
            
            // 3. No Data Error
            guard let data = data else {
                callback(.failure(NetworkError.noDataReceived))
                return
            }
            
            do  {
                // 4. Decoding Data
                let decoded = try JSONDecoder().decode(T.self, from: data)
                callback(.success(decoded))
            } catch {
                // 5. Decoding Error Handling
                guard let decodingError = error as? DecodingError else {
                    callback(.failure(NetworkError.unknowError(error)))
                    return
                }
                
                callback(.failure(NetworkError.decodingError(decodingError)))
            }
            
        }
        .resume()
    }
}

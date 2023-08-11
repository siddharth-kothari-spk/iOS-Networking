//
//  CallbackToCombineAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
import Combine

struct CallbackToCombineAdapter: CombineUserService {
    let networkService: CallbackNetworkService
    
    init(networkService: CallbackNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID) -> AnyPublisher<User, Error> {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        
        return Deferred {
            Future { promise in
                self.networkService.get(url: url, callback: promise)
            }
        }
        .eraseToAnyPublisher()
    }
}

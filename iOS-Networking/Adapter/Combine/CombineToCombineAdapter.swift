//
//  CombineToCombineAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
import Combine

class CombineToCombineAdapter: CombineUserService {
    let networkService: CombineNetworkService
    
    init(networkService: CombineNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID) -> AnyPublisher<User, Error> {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        return self.networkService
            .get(url: url)
    }
}

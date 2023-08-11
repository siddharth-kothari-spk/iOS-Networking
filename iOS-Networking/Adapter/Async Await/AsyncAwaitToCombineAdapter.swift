//
//  AsyncAwaitToCombineAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
import Combine

struct AsyncAwaitToCombineAdapter: CombineUserService {
    let networkService: AsyncAwaitNetworkService
    
    init(networkService: AsyncAwaitNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID) -> AnyPublisher<User, Error> {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        return Deferred {
            Future { promise in
                Task {
                    do {
                        let result: User = try await self.networkService.get(url: url)
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}

//
//  AsyncAwaitToCallbackAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation

struct AsyncAwaitToCallbackAdapter: CallbackUserService {
    let networkService: AsyncAwaitNetworkService
    
    init(networkService: AsyncAwaitNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID, callback: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        Task {
            do {
                let result: User = try await self.networkService.get(url: url)
                callback(.success(result))
            } catch {
                callback(.failure(error))
            }
        }
    }
}

//
//  CallbackToAsyncAwaitAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
struct CallbackToAsyncAwaitAdapter: AsyncAwaitUserService {
    let networkService: CallbackNetworkService
    
    init(networkService: CallbackNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID) async throws -> User {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        return try await withCheckedThrowingContinuation { continuation in
            self.networkService.get(url: url) { result in
                continuation.resume(with: result)
            }
        }
    }
}

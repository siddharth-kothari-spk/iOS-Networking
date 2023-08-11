//
//  AsyncAwaitToAsyncAwaitAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation

struct AsyncAwaitToAsyncAwaitAdapter: AsyncAwaitUserService {
    let networkService: AsyncAwaitNetworkService
    
    init(networkService: AsyncAwaitNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID) async throws -> User {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        return try await self.networkService.get(url: url)
    }
}

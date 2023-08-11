//
//  CombineToAsyncAwaitAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
import Combine

class CombineToAsyncAwaitAdapter: AsyncAwaitUserService {
    let networkService: CombineNetworkService
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkService: CombineNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID) async throws -> User {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        return try await withCheckedThrowingContinuation { continuation in
            self.networkService.get(url: url)
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    },
                    receiveValue: { (value: User) in
                        continuation.resume(returning: value)
                    }
                )
                .store(in: &cancellables)
        }
    }
}

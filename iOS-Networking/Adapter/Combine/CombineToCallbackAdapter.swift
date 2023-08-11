//
//  CombineToCallbackAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
import Combine

class CombineToCallbackAdapter: CallbackUserService {
    let networkService: CombineNetworkService
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkService: CombineNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID, callback: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        self.networkService.get(url: url)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        callback(.failure(error))
                    }
                },
                receiveValue: { (value: User) in
                    callback(.success(value))
                }
            )
            .store(in: &cancellables)
    }
}

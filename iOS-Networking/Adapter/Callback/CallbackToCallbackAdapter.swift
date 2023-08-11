//
//  CallbackToCallbackAdapter.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
struct CallbackToCallbackAdapter: CallbackUserService {
    let networkService: CallbackNetworkService
    
    init(networkService: CallbackNetworkService) {
        self.networkService = networkService
    }
    
    func getUser(id: UUID, callback: @escaping (Result<User, Error>) -> Void) {
        let url = URL(string: "https://www.myServer.com/user")!
            .appendingPathComponent("\(id.uuidString)")
        self.networkService.get(url: url, callback: callback)
    }
}

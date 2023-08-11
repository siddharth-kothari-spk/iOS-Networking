//
//  Protocols.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
import Combine

protocol CallbackUserService {
    func getUser(id: UUID, callback: @escaping (Result<User, Error>) -> Void)
}

protocol CombineUserService {
    func getUser(id: UUID) -> AnyPublisher<User, Error>
}

protocol AsyncAwaitUserService {
    func getUser(id: UUID) async throws -> User
}

//
//  UserModel.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation
struct User: Decodable {
    let id: UUID
    let name: String
    let surname: String
    let age: Int
    let subscriptionDate: Date
}

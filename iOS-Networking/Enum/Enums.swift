//
//  Enums.swift
//  iOS-Networking
//
//  Created by Siddharth Kothari on 11/08/23.
//

import Foundation

enum NetworkError: Error {
    case serverError(statusCode: Int?)
    case noDataReceived
    case decodingError(DecodingError)
    case unknowError(Error)
}

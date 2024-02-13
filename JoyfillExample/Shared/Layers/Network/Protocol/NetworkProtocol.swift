//
//  NetworkProtocol.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

public protocol NetworkProtocol {
    func request<T: Decodable, U: Endpoint>(
        _ endpoint: U, expectedType: T.Type,
        _ onResponse: @escaping (Result<T, Error>) -> Void
    )
}

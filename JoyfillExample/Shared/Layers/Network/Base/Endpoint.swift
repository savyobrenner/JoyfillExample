//
//  Endpoint.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

public protocol Endpoint {
    var requiresToken: Bool { get }
    var baseURL: URL { get }
    var path: String { get }
    var method: HttpMethod { get }
    var task: HTTPTask { get }
    var headers: [String: String]? { get }
    var timeoutInterval: TimeInterval { get }
}

extension Endpoint {
    var baseURL: URL {
        URL(string: AppEnvironment.baseURL)!
    }
    
    var headers: [String: String]? {
        var headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        if requiresToken {
            headers["Authorization"] = "Bearer \(AppEnvironment.userToken)"
        }
        
        return headers
    }
    
    var timeoutInterval: TimeInterval {
        return 60
    }
}

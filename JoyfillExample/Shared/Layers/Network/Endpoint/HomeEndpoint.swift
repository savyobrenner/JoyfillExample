//
//  HomeEndpoint.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

enum HomeEndpoint {
    case getDocumentsList
}

extension HomeEndpoint: Endpoint {
    var requiresToken: Bool {
        true
    }
    
    var path: String {
        switch self {
        case .getDocumentsList:
            return "v1/documents"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getDocumentsList:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getDocumentsList:
            return .requestParameters(
                parameters: [
                    "limit": 25,
                    "page": 1,
                    "type": "document"
                ],
                encoding: .url
            )
        }
    }
}

//
//  DocumentEndpoint.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import Foundation

enum DocumentEndpoint {
    case getDocument(id: String)
    case updateDocument(id: String, changelogs: Any)
}

extension DocumentEndpoint: Endpoint {
    var requiresToken: Bool {
        true
    }
    
    var path: String {
        switch self {
        case let .getDocument(id):
            return "v1/documents/\(id)"
        case let .updateDocument(id, _):
            return "v1/documents/\(id)/changelogs"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getDocument:
            return .get
        case .updateDocument:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getDocument:
            return .requestPlain
            
        case let .updateDocument(_, changelogs):
            let jsonData = try? JSONSerialization.data(withJSONObject: changelogs, options: [])
            return .requestBody(body: jsonData)
        }
    }
}


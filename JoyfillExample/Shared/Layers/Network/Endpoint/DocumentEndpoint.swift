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
    case exportPDF(id: String)
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
        case let .exportPDF(id):
            return "v1/documents/\(id)/exports/pdf"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getDocument:
            return .get
        case .updateDocument, .exportPDF:
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
        case .exportPDF:
            return .requestParameters(parameters: ["timezone": "UTC"], encoding: .url)
        }
    }
}


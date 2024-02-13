//
//  Component.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

struct Component: Codable {
    let id: String?
    let type: String?
    let stage: String?
    let source: String?
    let identifier: String?
    let name: String?
    let createdOn: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type, stage, source, identifier, name, createdOn
    }
}

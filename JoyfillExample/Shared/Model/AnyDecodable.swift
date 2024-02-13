//
//  AnyDecodable.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import Foundation

//struct AnyDecodable: Decodable {
//    let value: Data
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if let intValue = try? container.decode(Int.self) {
//            value = intValue
//        } else if let doubleValue = try? container.decode(Double.self) {
//            value = doubleValue
//        } else if let stringValue = try? container.decode(String.self) {
//            value = stringValue
//        } else if let boolValue = try? container.decode(Bool.self) {
//            value = boolValue
//        } else if let dictionaryValue = try? container.decode([String: AnyDecodable].self) {
//            value = dictionaryValue.mapValues { $0.value }
//        } else if let arrayValue = try? container.decode([AnyDecodable].self) {
//            value = arrayValue.map { $0.value }
//        } else {
//            throw DecodingError.dataCorruptedError(in: container, debugDescription: "The container contains an unsupported type.")
//        }
//    }
//}

//
//  ExportPDFModel.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import Foundation

struct ExportPDFModel: Codable {
    let downloadURL: String
    let previewURL: String
    
    enum CodingKeys: String, CodingKey {
        case downloadURL = "download_url"
        case previewURL = "preview_url"
    }
}

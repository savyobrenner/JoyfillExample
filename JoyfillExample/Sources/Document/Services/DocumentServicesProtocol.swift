//
//  DocumentServicesProtocol.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import Foundation

protocol DocumentServicesProtocol {
    func getDocument(with identifier: String, onCompletion: @escaping (Result<Data, Error>) -> Void)
    func updateDocument(
        with identifier: String,
        changelogs: Any,
        onCompletion: @escaping (Result<Component, Error>) -> Void
    )
    func exportDocument(with identifier: String, onCompletion: @escaping (Result<ExportPDFModel, Error>) -> Void)
}


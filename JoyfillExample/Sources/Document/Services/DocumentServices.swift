//
//  DocumentServices.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import Foundation

final class DocumentServices: DocumentServicesProtocol {
    private let network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getDocument(with identifier: String, onCompletion: @escaping (Result<Data, Error>) -> Void) {
        network.request(
            DocumentEndpoint.getDocument(id: identifier),
            expectedType: Data.self,
            onCompletion
        )
    }
    
    func updateDocument(
        with identifier: String,
        changelogs: Any,
        onCompletion: @escaping (Result<Component, Error>) -> Void
    ) {
        network.request(
            DocumentEndpoint.updateDocument(id: identifier, changelogs: changelogs),
            expectedType: Component.self,
            onCompletion
        )
    }
}


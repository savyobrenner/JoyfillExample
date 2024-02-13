//
//  HomeServices.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

final class HomeServices: HomeServicesProtocol {
    private let network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    func getDocumentsList(onCompletion: @escaping (Result<ComponentList, Error>) -> Void) {
        network.request(HomeEndpoint.getDocumentsList, expectedType: ComponentList.self, onCompletion)
    }
}

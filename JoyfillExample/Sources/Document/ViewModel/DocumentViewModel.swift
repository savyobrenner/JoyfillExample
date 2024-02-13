//
//  DocumentViewModel.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import Foundation

final class DocumentViewModel: DocumentViewModelProtocol {
    
    let services: DocumentServicesProtocol
    var id: String
    
    var loadForm: ((Data) -> Void)?
    
    init(services: DocumentServicesProtocol, id: String) {
        self.services = services
        self.id = id
    }
    
    func getDocument() {
        services.getDocument(with: id) { result in
            switch result {
            case .success(let success):
                self.loadForm?(success)
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
            }
        }
    }
}

private extension DocumentViewModel {
}

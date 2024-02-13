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
    var loading: ((Bool) -> Void)?
    var showAlert: ((String, String) -> Void)?
    
    init(services: DocumentServicesProtocol, id: String) {
        self.services = services
        self.id = id
    }
    
    func getDocument() {
        loading?(true)
        services.getDocument(with: id) { result in
            self.loading?(false)
            switch result {
            case .success(let success):
                self.loadForm?(success)
            case .failure(let failure):
                self.showAlert?("Error", failure.localizedDescription)
            }
        }
    }
    
    func updateDocument(with changelog: Any) {
        loading?(true)
        services.updateDocument(with: id, changelogs: changelog) { result in
            self.loading?(false)
            switch result {
            case .success:
                self.showAlert?("Success", "Your document has been successfully saved.")
            case .failure(let failure):
                self.showAlert?("Error", failure.localizedDescription)
            }
        }
    }
    
    func exportDocument() {
        loading?(true)
        services.exportDocument(with: id) { result in
            self.loading?(false)
            switch result {
            case .success(let success):
                // TODO: - Investigate backend response (500)
                break
            case .failure(let failure):
                self.showAlert?("Error", failure.localizedDescription)
            }
        }
    }
}

private extension DocumentViewModel {
}

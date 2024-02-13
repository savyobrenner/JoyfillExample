//
//  HomeViewModel.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {

    let services: HomeServicesProtocol
    
    var components: [Component] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var reloadData: (() -> Void)?
    var loading: ((Bool) -> Void)?
    var showAlert: ((String, String) -> Void)?
    
    init(services: HomeServicesProtocol) {
        self.services = services
    }
    
    func getDocumentsList() {
        loading?(true)
        services.getDocumentsList { result in
            self.loading?(false)
            switch result {
            case .success(let success):
                if let components = success.data {
                    self.components = components
                } else {
                    self.showAlert("Error", "Failed to get model data")
                }
                
            case .failure(let failure):
                self.showAlert("Error", failure.localizedDescription)
            }
        }
    }
}

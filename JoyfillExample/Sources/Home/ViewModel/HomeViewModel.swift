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
    
    init(services: HomeServicesProtocol) {
        self.services = services
    }
    
    func getDocumentsList() {
        services.getDocumentsList { result in
            switch result {
            case .success(let success):
                if let components = success.data {
                    self.components = components
                } else {
                    debugPrint("Failed to get model data")
                }
                
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
            }
        }
    }
}

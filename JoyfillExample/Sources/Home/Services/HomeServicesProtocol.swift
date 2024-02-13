//
//  HomeServicesProtocol.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

protocol HomeServicesProtocol { 
    func getDocumentsList(onCompletion: @escaping (Result<ComponentList, Error>) -> Void)
}

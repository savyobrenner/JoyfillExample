//
//  HomeViewModelProtocol.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 12/02/24.
//

import Foundation

protocol HomeViewModelProtocol {
    var components: [Component] { get set }
    var reloadData: (() -> Void)? { get set }
    var loading: ((Bool) -> Void)? { get set }
    var showAlert: ((String, String) -> Void)? { get set }
    func getDocumentsList()
}

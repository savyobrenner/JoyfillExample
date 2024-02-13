//
//  DocumentViewModelProtocol.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import Foundation

protocol DocumentViewModelProtocol {
    var id: String { get set }
    var loadForm: ((Data) -> Void)? { get set }
    var loading: ((Bool) -> Void)? { get set }
    var showAlert: ((String, String) -> Void)? { get set }
    func getDocument()
    func updateDocument(with changelog: Any)
    func exportDocument()
}

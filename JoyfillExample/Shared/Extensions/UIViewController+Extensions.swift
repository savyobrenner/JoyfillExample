//
//  UIViewController+Extensions.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, description: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
}

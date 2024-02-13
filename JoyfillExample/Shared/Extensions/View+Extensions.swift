//
//  View+Extensions.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import UIKit

extension UIView {
    func showLoading() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tag = 1
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            if let activityIndicator = self.viewWithTag(1) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}

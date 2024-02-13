//
//  DocumentViewController.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import JoyfillComponents
import UIKit

class DocumentViewController: UIViewController {
    
    var viewModel: DocumentViewModelProtocol
    
    init(viewModel: DocumentViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupView()
    }
}

// MARK: - Joyfill Delegate
extension DocumentViewController: onChange {
    func handleImageUploadAsync(images: [String]) {
        
    }
    
    func handleOnBlur(blurAndFocusParams: [String : Any]) {
        
    }
    
    func handleOnFocus(blurAndFocusParams: [String : Any]) {
        
    }
    
    func handleOnChange(docChangelog: [String : Any], doc: [String : Any]) {
        
    }
    
}

private extension DocumentViewController {
    func bindUI() {
        viewModel.loadForm = { [weak self] in
            guard let self else { return }
            
            jsonData = $0

            DispatchQueue.main.async {
                
                let joyfillForm = JoyfillForm()
                joyfillForm.mode = "fill"
                joyfillForm.saveDelegate = self
                joyfillForm.translatesAutoresizingMaskIntoConstraints = false
                
                
                self.view.addSubview(joyfillForm)
                
                NSLayoutConstraint.activate([
                    joyfillForm.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -12),
                    joyfillForm.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                    joyfillForm.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                    joyfillForm.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
                ])
                
                joyfillFormImageUpload = {
                    // TODO: - Get Photos From Gallery
                }
            }
        }
    }
    
    func setupView() {
        viewModel.getDocument()
        
        if let navigationController {
            joyfillNavigationController = navigationController
        }
    }
}

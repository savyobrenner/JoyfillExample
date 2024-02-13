//
//  DocumentViewController.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 13/02/24.
//

import JoyfillComponents
import UIKit

class DocumentViewController: UIViewController {
    
    private lazy var saveButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Save"
        config.baseBackgroundColor = .systemBlue.withAlphaComponent(0.08)
        config.baseForegroundColor = .systemBlue
        config.buttonSize = .medium
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var exportPDFButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Export PDF"
        config.baseBackgroundColor = .systemRed.withAlphaComponent(0.08)
        config.baseForegroundColor = .systemRed
        config.buttonSize = .medium
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [saveButton, exportPDFButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
    func handleImageUploadAsync(images: [String]) { }
    
    func handleOnBlur(blurAndFocusParams: [String : Any]) { }
    
    func handleOnFocus(blurAndFocusParams: [String : Any]) { }
    
    func handleOnChange(docChangelog: [String : Any], doc: [String : Any]) { }
    
}

// MARK: - UIImagePickerControllerDelegate
extension DocumentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[.editedImage] as? UIImage else { return }
        
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            let base64String = imageData.base64EncodedString()
            onUploadAsync(imageUrl: "data:image/jpeg;base64,\(base64String)")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
                    joyfillForm.bottomAnchor.constraint(equalTo: self.saveButton.topAnchor, constant: -10)
                ])
                
                joyfillFormImageUpload = {
                    self.openImagePicker()
                }
            }
        }
        
        viewModel.loading = { [weak self] in
            if $0 {
                self?.view.showLoading()
            } else {
                self?.view.hideLoading()
            }
        }
        
        viewModel.showAlert = { [weak self] in
            self?.showAlert(title: $0, description: $1)
        }
    }
    
    func setupView() {
        viewModel.getDocument()
        setupButtons()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = .white
        
        if let navigationController {
            joyfillNavigationController = navigationController
        }
    }
    
    func setupButtons() {
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        exportPDFButton.addTarget(self, action: #selector(exportPDFButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        viewModel.updateDocument(with: docChangeLogs)
    }
    
    @objc func exportPDFButtonTapped() {
        viewModel.exportDocument()
    }
}

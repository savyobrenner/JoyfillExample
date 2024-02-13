//
//  HomeViewController.swift
//  JoyfillExample
//
//  Created by Savyo Brenner on 11/02/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol
    
    private lazy var homeView: HomeView = {
        let homeView = HomeView()
        homeView.setDelegate(self)
        return homeView
    }()
    
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        fetchData()
    }
}

extension HomeViewController: JFTableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.components.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewCell.identifier, for: indexPath) as? HomeViewCell else {
            return UITableViewCell()
        }
        
        let component = viewModel.components[indexPath.row]
        cell.configure(with: component.name, date: component.createdOn)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        navigateToDocument(with: indexPath)
    }
}

private extension HomeViewController {
    func bindUI() {
        viewModel.reloadData = { [weak self] in
            self?.homeView.reloadData()
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
    
    func fetchData() {
        viewModel.getDocumentsList()
    }
    
    func navigateToDocument(with indexPath: IndexPath) {
        let selectedDocument = viewModel.components[indexPath.row]
        
        guard let identifier = selectedDocument.identifier else { return }
        
        let services = DocumentServices(network: NetworkManager())
        let viewModel = DocumentViewModel(services: services, id: identifier)
        let viewController = DocumentViewController(viewModel: viewModel)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

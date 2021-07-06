//
//  ListCoordinator.swift
//  ProductViewer
//
//  Copyright © 2016 Target. All rights reserved.
//

import Foundation
import Tempo

/*
 Coordinator for the product list
 */
class ListCoordinator: TempoCoordinator {
    
    // MARK: Presenters, view controllers, view state.
    var errorOccurred: ((NetworkError) -> Void) = {_ in  }

    var presenters = [TempoPresenterType]() {
        didSet {
            updateUI()
        }
    }
    
    fileprivate var viewState: ListViewState {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        for presenter in presenters {
            presenter.present(viewState)
        }
    }
    
    let dispatcher = Dispatcher()
    
    lazy var viewController: ListViewController = {
        return ListViewController.viewControllerFor(coordinator: self)
    }()
    
    // MARK: Init
    
    required init() {
        viewState = ListViewState(listItems: [])
        updateState()
        registerListeners()
    }
    
    // MARK: ListCoordinator
    
    fileprivate func registerListeners() {
        dispatcher.addObserver(ListItemPressed.self) { [weak self] e,item  in
            let detailViewController = ProductDetailViewController()
            detailViewController.productItem = item as? ListItemViewState
            self?.viewController.present(detailViewController, animated: true, completion: nil)
        }
    }
    
    func updateState() {
        fetchProductList()
    }
    
    private func fetchProductList(networkManager: NetworkManager = NetworkManager()) {
        if let request = RequestCreator.createRequest(with: URLConstants.baseUrl + URLConstants.deals) {
            networkManager.fetchData(request: request) { (result) in
                switch result {
                case .success(let responseData):
                    if let productModelList: ProductList = JSONParser.decodeJson(from: responseData) {
                        self.viewState.listItems = (0..<productModelList.products.count).map { index in
                            let product = productModelList.products[index]
                            return ListItemViewState(id: product.id, title: product.title, description: product.description, priceStr: product.displayString, imageUrl: product.imageUrl, currencySymbol: product.currencySymbol)
                        }
                    }
                    else {
                        self.errorOccurred(.invalidData)
                    }
                case .failure(let error):
                    self.errorOccurred(error)
                }
            }
        }
    }
}

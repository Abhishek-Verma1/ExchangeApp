//
//  SelectionViewPresenter.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

class SuccessScreenPresenter: SuccessPresenterProtocol {
    
    func viewDidLoad() {
        
    }
    
    var view: SuccessViewProtocol?
    var interactor: SuccessInteractorInputProtocol?
    var router: SuccessRouterProtocol?
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        if let view = view {
            router?.navigateToSelectionView(from: view)
        }
    }
    
    func navigateSelectionView() {
        if let view = view {
            router?.navigateToSelectionView(from: view)
        }
    }
    
    func showDetails(for view: SuccessViewProtocol) {
        router?.navigateToSelectionView(from: view)
    }
}

extension SuccessScreenPresenter: SuccessInteractorOutputProtocol {
    func loadFinished(_ result: CurrencyExchangeModel?, convertionAmountWithCurrency: String) {
        view?.loadFinished(result, convertionAmountWithCurrency: convertionAmountWithCurrency)
    }
    
    func loadOnError() {
        
    }
}


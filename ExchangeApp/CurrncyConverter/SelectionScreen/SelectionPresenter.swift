//
//  SelectionViewPresenter.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

class SelectionViewPresenter: SelectionPresenterProtocol {
    var view: SelectionViewProtocol?
    var interactor: SelectionInteractorInputProtocol?
    var router: SelectionRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchDatas()
    }
    
    func showDetails(for fromItem: CurrencyEntity, toItem: CurrencyEntity, amount: Int) {
        router?.presentPostCalculateScreen(from: view!, for: fromItem, toData: toItem, amount: amount)
    }
}

extension SelectionViewPresenter: SelectionInteractorOutputProtocol {
    func loadOnError() {
        // Error
    }
    
    func loadFinished(with datas: [CurrencyEntity]) {
        view?.showDatas(with: datas)
    }
}

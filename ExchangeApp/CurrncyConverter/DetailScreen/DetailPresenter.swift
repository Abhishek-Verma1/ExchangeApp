//
//  DetailPresenter.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import Foundation

#warning("Optimization is required in the next sprint.")
class DetailPresenter: PresenterProtocol {
    var fromCurrency: CurrencyEntity?
    var toCurrency: CurrencyEntity?
    var amount: Int?
    
    var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var router: DetailRouterProtocol?
    var items: CurrencyExchangeModel?
    var timer: Timer?
    var second = 30
    
    func viewDidLoad() {
        if let fromCurrency = fromCurrency,
           let toCurrency = toCurrency,
           let amount = amount {
            interactor?.fetchDatas(fromCurrency: fromCurrency, toCurrency: toCurrency, amount: amount)
        }
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func showSuccessScreen(data: CurrencyExchangeModel, convertionAmountWithCurrency: String) {
        router?.showSuccessScreen(from: view!, data: data, convertionAmountWithCurrency: convertionAmountWithCurrency)
    }
    
    func popToSelectionView() {
        router?.dismiss(from: view!)
    }
    
    @objc func update(timer: Timer) {
        second -= 1
        if second == 1 {
            timer.invalidate()
            view?.endCountdown()
        }
        view?.countdownTimer(value: second)
    }
    
    subscript(index: Int) -> CurrencyExchangeModel? {
        guard let items = items else { return nil }
        return items
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {
    func loadFinished(_ result: CurrencyExchangeModel?) {
        self.items = result
        if let result = result {
            view?.updateData(value: result)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update(timer:)), userInfo: nil, repeats: true)
        }
    }
    
    func loadOnError(_ error: Error?) {
        view?.showError(error)
    }
}

//
//  DetailProtocols.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

protocol PresenterProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }
    var router: DetailRouterProtocol? { get set }
    var fromCurrency: CurrencyEntity? { get set }
    var toCurrency: CurrencyEntity? { get set }
    var amount: Int? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showSuccessScreen(data: CurrencyExchangeModel, convertionAmountWithCurrency: String)
    func popToSelectionView()
    subscript(index: Int) -> CurrencyExchangeModel? { get }
}

protocol DetailInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func loadFinished(_ result: CurrencyExchangeModel?)
    func loadOnError(_ error: Error?)
}

protocol DetailInteractorInputProtocol: AnyObject {
    var presenter: DetailInteractorOutputProtocol? { get set }
    // PRESENTER -> INTERACTOR
    func fetchDatas(fromCurrency: CurrencyEntity, toCurrency: CurrencyEntity, amount: Int)
}

protocol DetailViewProtocol {
    var presenter: PresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func updateData(value: CurrencyExchangeModel)
    func countdownTimer(value: Int)
    func endCountdown()
    func showError(_ error: Error?)
}

protocol DetailRouterProtocol {
    static func createModule(fromCurrency: CurrencyEntity, toCurrency: CurrencyEntity, amount: Int) -> UIViewController
    
    // PRESENTER -> Router
    func dismiss(from view: DetailViewProtocol)
    func showSuccessScreen(from view: DetailViewProtocol, data: CurrencyExchangeModel, convertionAmountWithCurrency: String)
}



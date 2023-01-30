//
//  NormalMainProtocols.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

protocol SuccessPresenterProtocol: AnyObject {
    var view: SuccessViewProtocol? { get set }
    var interactor: SuccessInteractorInputProtocol? { get set }
    var router: SuccessRouterProtocol? { get set }

    // VIEW -> PRESENTER
    func viewDidLoad()
    func navigateSelectionView()
}

protocol SuccessInteractorInputProtocol: AnyObject {
    var presenter: SuccessInteractorOutputProtocol? { get set }
}

protocol SuccessInteractorOutputProtocol: AnyObject {
    func loadFinished(_ result: CurrencyExchangeModel?, convertionAmountWithCurrency: String)
    func loadOnError()
}

protocol SuccessViewProtocol {
    var presenter: SuccessPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func loadFinished(_ result: CurrencyExchangeModel?, convertionAmountWithCurrency: String)
}

protocol SuccessRouterProtocol {
    func navigateToSelectionView(from view: SuccessViewProtocol)
    static func createModule(with data: CurrencyExchangeModel, convertionAmountWithCurrency: String) -> UIViewController
}

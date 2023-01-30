//
//  NormalMainProtocols.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

protocol SelectionPresenterProtocol: AnyObject {
    var view: SelectionViewProtocol? { get set }
    var interactor: SelectionInteractorInputProtocol? { get set }
    var router: SelectionRouterProtocol? { get set }

    // VIEW -> PRESENTER
    func viewDidLoad()
    func showDetails(for fromItem: CurrencyEntity, toItem: CurrencyEntity, amount: Int)
}

protocol SelectionInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
    func loadFinished(with datas: [CurrencyEntity])
    func loadOnError()
}

protocol SelectionInteractorInputProtocol: AnyObject {
    var presenter: SelectionInteractorOutputProtocol? { get set }
    // PRESENTER -> INTERACTOR
    func fetchDatas()
    func getAllCountryList() -> [CurrencyEntity]
}

protocol SelectionViewProtocol {
    var presenter: SelectionPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func showDatas(with datas: [CurrencyEntity])
}

protocol SelectionRouterProtocol {
    static func createModule() -> UIViewController

    // PRESENTER -> Router
    func presentPostCalculateScreen(from view: SelectionViewProtocol, for fromData: CurrencyEntity, toData: CurrencyEntity, amount: Int)
    func getDetailViewController(from view: SelectionViewProtocol, for fromData: CurrencyEntity, toData: CurrencyEntity, amount: Int) -> UIViewController
}



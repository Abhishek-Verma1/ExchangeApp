//
//  NormalMainRouter.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

#warning("Optimization is required in the next sprint.")
class SelectionRouter: SelectionRouterProtocol {

    class func createModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "MainView")
        if let view = view as? SelectionView {
            let presenter: SelectionPresenterProtocol & SelectionInteractorOutputProtocol = SelectionViewPresenter()
            let interactor: SelectionInteractorInputProtocol = SelectionViewInteractor()
            let router: SelectionRouterProtocol = SelectionRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return view
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func getDetailViewController(from view: SelectionViewProtocol, for fromData: CurrencyEntity, toData: CurrencyEntity, amount: Int) -> UIViewController {
        return DetailRouter.createModule(fromCurrency: fromData, toCurrency: toData, amount: amount)
    }
    
    func presentPostCalculateScreen(from view: SelectionViewProtocol, for fromData: CurrencyEntity, toData: CurrencyEntity, amount: Int) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(DetailRouter.createModule(fromCurrency: fromData, toCurrency: toData, amount: amount), animated: true)
        }
    }
}

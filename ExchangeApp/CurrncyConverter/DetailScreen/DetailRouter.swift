//
//  DetailRouter.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

class DetailRouter: DetailRouterProtocol {
    
    func dismiss(from view: DetailViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popViewController(animated: true)
        }
    }
    
    func showSuccessScreen(from view: DetailViewProtocol, data: CurrencyExchangeModel, convertionAmountWithCurrency: String) {
        let viewController = SuccessRouter.createModule(with: data, convertionAmountWithCurrency: convertionAmountWithCurrency)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    static func createModule(fromCurrency: CurrencyEntity, toCurrency: CurrencyEntity, amount: Int) -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "DetailView")
        if let view = view as? DetailView {
            let presenter: PresenterProtocol & DetailInteractorOutputProtocol = DetailPresenter()
            let interactor: DetailInteractorInputProtocol = DetailInteractor()
            let router: DetailRouterProtocol = DetailRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.fromCurrency = fromCurrency
            presenter.toCurrency = toCurrency
            presenter.amount = amount
            interactor.presenter = presenter
            
            return view
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

//
//  SuccessRouter.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

class SuccessRouter: SuccessRouterProtocol {

    #warning("Optimization is required in the next sprint.")
    static func createModule(with data: CurrencyExchangeModel, convertionAmountWithCurrency: String) -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "SuccessView")
        if let view = view as? SuccessView {
            let presenter: SuccessPresenterProtocol & SuccessInteractorOutputProtocol = SuccessScreenPresenter()
            let interactor: SuccessInteractorInputProtocol = SuccessInteractor()
            let router: SuccessRouterProtocol = SuccessRouter()
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            presenter.loadFinished(data, convertionAmountWithCurrency: convertionAmountWithCurrency)
            interactor.presenter = presenter
            
            return view
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    func navigateToSelectionView(from view: SuccessViewProtocol) {
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popToRootViewController(animated: true)
        }
    }
}

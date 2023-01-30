//
//  SelectionViewInteractor.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

class SelectionViewInteractor: SelectionInteractorInputProtocol {
    var presenter: SelectionInteractorOutputProtocol?
    
    func getAllCountryList() -> [CurrencyEntity] {
        return CurrencyEntity.allCases
    }
    
    func fetchDatas() {
        presenter?.loadFinished(with: getAllCountryList())
    }
}

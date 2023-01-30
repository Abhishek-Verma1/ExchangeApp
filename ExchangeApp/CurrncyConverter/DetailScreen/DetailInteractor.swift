//
//  DetailInteractor.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import Foundation

#warning("Optimization is required in the next sprint.")
struct CurrencyExchangeModel: Codable {
    var result: String?
    var documentation: String?
    var terms_of_use: String?
    var time_last_update_unix: Double?
    var time_last_update_utc: String?
    var time_next_update_unix: Double?
    var time_next_update_utc: String?
    var base_code: String
    var target_code: String
    var conversion_rate: Double
    var log_date: Date?
}

class DetailInteractor: DetailInteractorInputProtocol {
    var presenter: DetailInteractorOutputProtocol?
    
    func fetchDatas(fromCurrency: CurrencyEntity, toCurrency: CurrencyEntity, amount: Int) {
        
        if let value = OfflineDataModel.checkAndRetriveCurrentValue(baseCode: fromCurrency.rawValue, targetCode: toCurrency.rawValue) {
            DispatchQueue.main.async {
                self.presenter?.loadFinished(value)
            }
            return
        }
        let endpoint = Constants.EndPoint.exchangeRate + "\(fromCurrency.rawValue)/\(toCurrency.rawValue)"
        NetworkManager.shared.request(endpoint, httpType: .GET, forType: .type(CurrencyExchangeModel.self), callback: { result in
            switch result {
            case .success(response: let response):
                // parse response here
                var result = response
                result.log_date = Date()
                _ = OfflineDataModel.saveModel(model: result)
                DispatchQueue.main.async {
                    self.presenter?.loadFinished(result)
                }
            case .failure(error: let error):
                self.presenter?.loadOnError(error)
            }
        })
    }
}

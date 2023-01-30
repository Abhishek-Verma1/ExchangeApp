//
//  OfflineDataModel.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import Foundation

class OfflineDataModel {
    static func saveModel(model: CurrencyExchangeModel) -> Bool {
        var mutableArray = Array(retriveModel())
        mutableArray.removeAll(where: {
            $0.base_code == model.base_code && $0.target_code == model.target_code
        })
        mutableArray.append(model)
        return saveModelArray(array: mutableArray)
    }
    
    static func saveModelArray(array: [CurrencyExchangeModel]) -> Bool {
        if let encoded = try? JSONEncoder().encode(array) {
            UserDefaults.standard.set(encoded, forKey: Constants.UserDefaults.modelArray)
            return true
        }
        return false
    }
    
    static func deleteModel(model: CurrencyExchangeModel) -> Bool {
        var mutableArray = Array(retriveModel())
        mutableArray.removeAll(where: {
            $0.base_code == model.base_code && $0.target_code == model.target_code
        })
        if let encoded = try? JSONEncoder().encode(mutableArray) {
            UserDefaults.standard.set(encoded, forKey: Constants.UserDefaults.modelArray)
            return true
        }
        return false
    }
    
    static func checkAndRetriveCurrentValue(baseCode: String, targetCode: String) -> CurrencyExchangeModel? {
        var mutableArray = Array(retriveModel())
        mutableArray = mutableArray.filter({
            $0.target_code == targetCode && $0.base_code == baseCode
        })
        if mutableArray.count > 0 {
            return mutableArray.first
        }
        return nil
    }
    
#warning("Optimization is required in the next sprint.")
    static func retriveModel() -> [CurrencyExchangeModel] {
        guard let placesData = UserDefaults.standard.object(forKey: Constants.UserDefaults.modelArray) as? Data else {
            return []
        }
        do {
            let storedItems = try JSONDecoder().decode([CurrencyExchangeModel].self, from: placesData)
            let filteredArray = storedItems.map({value -> (CurrencyExchangeModel, Int?) in
                let diffComponents = Calendar.current.dateComponents([.hour], from: value.log_date ?? Date(), to: Date())
                let hours = diffComponents.hour
                return (value, hours)
            })
                .filter({($1 ?? 0) < 5})
                .map({ (value, hours) in
                    return value
                })
            if storedItems.count != filteredArray.count {
                _ = saveModelArray(array: filteredArray)
            }
            return filteredArray
        } catch let err {
            print(err)
        }
        return []
    }
}

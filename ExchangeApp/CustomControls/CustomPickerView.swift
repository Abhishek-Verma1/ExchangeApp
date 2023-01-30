//
//  CustomPickerView.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

class CustomPickerView: UIPickerView {
    typealias ClosureType = ( (CurrencyEntity) -> Void)
    
    var didSelectValue: ClosureType?
    
    func initialise(with closureType: @escaping ClosureType, defaultValue: CurrencyEntity) {
        self.didSelectValue = closureType
        self.delegate = self
        self.dataSource = self
        let index = CurrencyEntity.allCases.firstIndex(of: CurrencyEntity(rawValue: defaultValue.rawValue) ?? .GBP) ?? 0
        selectRow(index, inComponent: 0, animated: true)
    }
}

extension CustomPickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CurrencyEntity.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CurrencyEntity.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.didSelectValue?(CurrencyEntity.allCases[row])
    }
}

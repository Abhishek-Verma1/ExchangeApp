//
//  CustomTextField.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    var didChangeValue: ((CurrencyEntity) -> Void)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(inputView: UIView? = nil, text: String) {
        addDoneButtonOnKeyboard()
        if let inputView = inputView {
            self.inputView = inputView
            self.text = text
        }
    }
}

//
//  CustomButton.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'shape' instead.")
    @IBInspectable var UseProjectTheme: Bool = false {
        willSet {
            if newValue {
                setProjectTheme()
            }
        }
    }
    
    func setProjectTheme() {
        backgroundColor = .red
        setTitleColor(.white, for: .normal)
    }
}



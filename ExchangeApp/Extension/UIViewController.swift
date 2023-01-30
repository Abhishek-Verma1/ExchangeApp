//
//  UIViewController.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround(viewToTap: UIView? = nil) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        if let viewToTap = viewToTap {
            viewToTap.addGestureRecognizer(tap)
        } else {
            view.addGestureRecognizer(tap)
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

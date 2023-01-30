//
//  NormalMainView.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

#warning("Optimization is required in the next sprint.")
enum CurrencyEntity: String, CaseIterable {
    case AUD
    case ATS
    case BEF
    case BRL
    case CAD
    case CHF
    case CNY
    case DEM
    case DKK
    case ESP
    case EUR
    case FIM
    case FRF
    case GBP
    case GRD
    case HKD
    case IEP
    case INR
    case IRR
    case ITL
    case JPY
    case KRW
    case LKR
    case MXN
    case MYR
    case NOK
    case NLG
    case NZD
    case PTE
    case SEK
    case SGD
    case THB
    case TWD
    case USD
    case ZAR
}

class SelectionView: UIViewController {
    var datas: [CurrencyEntity] = []
    var presenter: SelectionPresenterProtocol?
    
    @IBOutlet weak var amountTextField: CustomTextField!
    @IBOutlet weak var fromTextField: CustomTextField! {
        didSet {
            self.fromPicker.initialise(with: { value in
                self.fromCurrencySelected = value
            }, defaultValue: fromCurrencySelected)
            fromTextField.setup(inputView: self.fromPicker, text: fromCurrencySelected.rawValue)
        }
    }
    
    @IBOutlet weak var toTextField: CustomTextField! {
        didSet {
            self.toPicker.initialise(with: { value in
                self.toCurrencySelected = value
            }, defaultValue: toCurrencySelected)
            toTextField.setup(inputView: self.toPicker, text: toCurrencySelected.rawValue)
        }
    }
    
    private var fromPicker: CustomPickerView = CustomPickerView()
    private var toPicker: CustomPickerView = CustomPickerView()
    var fromCurrencySelected: CurrencyEntity = .GBP {
        didSet {
            fromTextField.text = fromCurrencySelected.rawValue
        }
    }
    
    var toCurrencySelected: CurrencyEntity = .EUR {
        didSet {
            toTextField.text = toCurrencySelected.rawValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        fromPicker.accessibilityIdentifier = "fromPicker"
        toPicker.accessibilityIdentifier = "toPicker"
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        if let text = amountTextField.text, let amount = Int(text) {
            presenter?.showDetails(for: fromCurrencySelected, toItem: toCurrencySelected, amount: amount)
        } else {
            let alert = UIAlertController(title: "Amount Required!", message: "Please enter some amount.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SelectionView: SelectionViewProtocol {
    func showDatas(with datas: [CurrencyEntity]) {
        self.datas = datas
    }
}

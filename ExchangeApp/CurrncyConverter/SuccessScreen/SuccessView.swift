//
//  SuccessView.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

class SuccessView: UIViewController {
    @IBOutlet weak var confirmAmountLabel: UILabel!
    @IBOutlet weak var convertionRateLabel: UILabel!
    var confirmationAmountLabel: String  = Constants.SuccessScreen.amountInAccount
    var convertionRate: String  = Constants.SuccessScreen.convertionRate
    var presenter: SuccessPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        self.confirmAmountLabel.text = confirmationAmountLabel
        convertionRateLabel.text = convertionRate
    }
     
    func setupNavigationBar() {
        if let sourceView = presenter?.view as? UIViewController {
            let rightButtonItem = UIBarButtonItem.init(
                  title: "Done",
                  style: .done,
                  target: self,
                  action: #selector(self.rightButtonTapped))
            
            sourceView.navigationItem.setHidesBackButton(true, animated: true)
            sourceView.navigationItem.rightBarButtonItem = rightButtonItem
        }
    }
    
    func loadFinished(_ result: CurrencyExchangeModel?, convertionAmountWithCurrency: String) {
        if let result = result {
            confirmationAmountLabel = self.confirmationAmountLabel.replacingOccurrences(of: "conversion_rate_amount", with: convertionAmountWithCurrency)
            convertionRate = self.convertionRate.replacingOccurrences(of: "conversion_rate", with: "\(result.conversion_rate)")
        }
    }
     
    @objc func rightButtonTapped() {
        presenter?.navigateSelectionView()
    }
}

extension SuccessView: SuccessViewProtocol {}

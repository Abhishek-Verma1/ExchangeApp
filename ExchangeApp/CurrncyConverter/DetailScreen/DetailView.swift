//
//  NormalDetailView.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

#warning("Optimization is required in the next sprint.")
class DetailView: UIViewController {
    @IBOutlet weak var fromCurrencyLabel: UILabel!
    @IBOutlet weak var toCurrencyLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var precedeLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    var data: CurrencyExchangeModel?
    
    var presenter: PresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLeftLabel.isHidden = true
        presenter?.viewDidLoad()
    }
    
    @IBAction func convertButtonTapped(sender: UIButton) {
        if let data = data {
            presenter?.showSuccessScreen(data: data, convertionAmountWithCurrency: toCurrencyLabel.text ?? "")
        }
    }
}

extension DetailView: DetailViewProtocol {
    func endCountdown() {
        let alert = UIAlertController(title: "Timeout", message: "Please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.presenter?.popToSelectionView()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError(_ error: Error?) {
        DispatchQueue.main.async {
            var errorMessage = Constants.Error.somethingWrong
            if let error = error {
                errorMessage = error.localizedDescription
            }
            let controller = UIAlertController(title: Constants.Error.error, message: errorMessage, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: Constants.Button.ok, style: .default, handler: {_ in
                self.presenter?.popToSelectionView()
            }))
            if errorMessage != Constants.Error.somethingWrong {
                controller.addAction(UIAlertAction(title: Constants.Button.retry, style: .default, handler: {_ in
                    self.presenter?.viewDidLoad()
                }))
            }
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func updateData(value: CurrencyExchangeModel) {
        self.data = value
        fromCurrencyLabel.text = "\(presenter?.amount ?? 1) \(value.base_code)"
        let afterConversionValue = Double(presenter?.amount ?? 1) * value.conversion_rate 
        toCurrencyLabel.text = "\(afterConversionValue.rounded(toPlaces: 2)) \(value.target_code)"
        timeLeftLabel.text = "30 Sec left"
        precedeLabel.isHidden = false
        timeLeftLabel.isHidden = false
        convertButton.isHidden = false
    }
    
    func countdownTimer(value: Int) {
        timeLeftLabel.text = "\(value) Sec left"
    }
}


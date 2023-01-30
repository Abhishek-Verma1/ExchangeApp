//
//  Constants.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import Foundation

final class Constants: NSObject {
    
    struct SuccessScreen {
        static let amountInAccount = "Great now you have conversion_rate_amount in your account"
        static let convertionRate = "Your convertion rate was 1/conversion_rate"
    }
    
    struct UserDefaults {
        static let modelArray = "datamodel"
    }
    
    struct EndPoint {
        static let exchangeRate = "https://v6.exchangerate-api.com/v6/70d1ada09febe26aa2a369b6/pair/"
    }
    
    struct Error {
        static let somethingWrong = "Something went wrong. Please try again!"
        static let error = "ERROR"
        static let timeout = "Timeout"
        static let tryagain = "Please try again."
    }
    
    struct Button {
        static let ok = "OK"
        static let retry = "Retry"
    }
}

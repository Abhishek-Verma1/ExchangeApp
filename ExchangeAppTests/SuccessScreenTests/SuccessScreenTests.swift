//
//  SuccessScreenTests.swift
//  SuccessScreenTests
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import XCTest
@testable import ExchangeApp

class SuccessScreenTests: XCTestCase {
    
    var selectionView: SuccessView!
    var convertionAmount = "12.0"
    
    override func setUp() {
        super.setUp()
        let vc = SuccessRouter.createModule(with: getMockData(), convertionAmountWithCurrency: convertionAmount)
        if let vc = vc as? SuccessView {
            selectionView = vc
        } else {
            XCTFail("DetailView is not retrived!")
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPresenter() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let presenter = try XCTUnwrap(selectionView.presenter)
        _ = try XCTUnwrap(presenter.view)
        _ = try XCTUnwrap(presenter.interactor)
        _ = try XCTUnwrap(presenter.router)
    }
    
    func testTextTitles() {
        let model = getMockData()
        selectionView.loadFinished(model, convertionAmountWithCurrency: convertionAmount)
        let expectedConfirmationAmountText = Constants.SuccessScreen.amountInAccount.replacingOccurrences(of: "conversion_rate_amount", with: convertionAmount)
        XCTAssertEqual(selectionView.confirmationAmountLabel, expectedConfirmationAmountText)
        let expectedConvertionRateText = Constants.SuccessScreen.convertionRate.replacingOccurrences(of: "conversion_rate", with: "\(model.conversion_rate)")
        XCTAssertEqual(selectionView.convertionRate, expectedConvertionRateText)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func getMockData() -> CurrencyExchangeModel {
        return CurrencyExchangeModel(result: "result", documentation: "documentation", terms_of_use: "terms_of_use", time_last_update_unix: 123456, time_last_update_utc: "time_last_update_utc", time_next_update_unix: 123456, time_next_update_utc: "time_next_update_utc", base_code: "USD", target_code: "INR", conversion_rate: 12.9)
    }

}

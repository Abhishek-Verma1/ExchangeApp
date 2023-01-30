//
//  DetailScreenTests.swift
//  DetailScreenTests
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import XCTest
@testable import ExchangeApp

class DetailScreenTests: XCTestCase {
    
    var selectionView: DetailView!
    
    override func setUp() {
        super.setUp()
        let vc = DetailRouter.createModule(fromCurrency: .USD, toCurrency: .INR, amount: 100)
        if let vc = vc as? DetailView {
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

    func testAPIExchangeData() {
        let expectation = expectation(description: "coverted")
        let endpoint = Constants.EndPoint.exchangeRate + "USD/INR"
        NetworkManager.shared.request(endpoint, httpType: .GET, forType: .type(CurrencyExchangeModel.self)) { result in
            switch result {
            case .success(response: let model):
                self.selectionView.data = model
                expectation.fulfill()
            case .failure(error: let error):
                XCTFail("\(error?.localizedDescription ?? "Default error message")")
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testOfflineData() {
        let model = getMockData()
        XCTAssertTrue(OfflineDataModel.saveModel(model: model))
        XCTAssertNotNil(OfflineDataModel.checkAndRetriveCurrentValue(baseCode: model.base_code, targetCode: model.target_code))
        XCTAssertTrue(OfflineDataModel.deleteModel(model: model))
        XCTAssertNil(OfflineDataModel.checkAndRetriveCurrentValue(baseCode: model.base_code, targetCode: model.target_code))
    }
    
    func testModelAfterFiveHour() {
        let earlyDate = Calendar.current.date(
          byAdding: .hour,
          value: -5,
          to: Date())
        var newModel = getMockData()
        newModel.log_date = earlyDate
        XCTAssertTrue(OfflineDataModel.saveModel(model: newModel))
        XCTAssertNil(OfflineDataModel.checkAndRetriveCurrentValue(baseCode: newModel.base_code, targetCode: newModel.target_code))
    }
    
    func testPresenter() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let presenter = try XCTUnwrap(selectionView.presenter)
        _ = try XCTUnwrap(presenter.interactor)
        _ = try XCTUnwrap(presenter.router)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func getMockData() -> CurrencyExchangeModel {
        return CurrencyExchangeModel(result: "result", documentation: "documentation", terms_of_use: "terms_of_use", time_last_update_unix: 123456, time_last_update_utc: "time_last_update_utc", time_next_update_unix: 123456, time_next_update_utc: "time_next_update_utc", base_code: "USD", target_code: "AED", conversion_rate: 3.75)
    }
}

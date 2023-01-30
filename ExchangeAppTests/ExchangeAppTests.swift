//
//  ExchangeAppTests.swift
//  ExchangeAppTests
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import XCTest
@testable import ExchangeApp

class VExchangeAppTests: XCTestCase {
    
    var selectionView: SelectionView!
    
    override func setUp() {
        super.setUp()
        let vc = SelectionRouter.createModule()
        if let vc = vc as? SelectionView {
            selectionView = vc
        } else {
            XCTFail("SelectionView is not retrived!")
        }
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSelectionRouter() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let presenter = try XCTUnwrap(selectionView.presenter)
        let interactor = try XCTUnwrap(presenter.interactor)
        let countryList = interactor.getAllCountryList()
        XCTAssertEqual(countryList.count, CurrencyEntity.allCases.count)
        let router = try XCTUnwrap(presenter.router)
        XCTAssertTrue(router.getDetailViewController(from: selectionView, for: selectionView.fromCurrencySelected, toData: selectionView.toCurrencySelected, amount: 10) is DetailView)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  ExchangeAppUITests.swift
//  ExchangeAppUITests
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import XCTest

class ExchangeAppUITests: XCTestCase {
    
    let waitTime = 5.0

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testApp() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let fromTextField = app.textFields["fromtextfield"]
        if fromTextField.waitForExistence(timeout: waitTime) {
            fromTextField.tap()
        } else {
            XCTFail("Element is Missing")
        }
        
        let fromPicker = app.pickers["fromPicker"]
        if fromPicker.waitForExistence(timeout: waitTime) {
            fromPicker.pickerWheels.element.adjust(toPickerWheelValue: "USD")
        } else {
            XCTFail("Element is Missing")
        }
        
        let toTextField = app.textFields["totextfield"]
        if toTextField.waitForExistence(timeout: waitTime) {
            toTextField.tap()
        } else {
            XCTFail("Element is Missing")
        }
        
        let toPicker = app.pickers["toPicker"]
        if toPicker.waitForExistence(timeout: waitTime) {
            toPicker.pickerWheels.element.adjust(toPickerWheelValue: "INR")
        } else {
            XCTFail("Element is Missing")
        }
        
        let doneButton = app.buttons["donebutton"]
        if doneButton.waitForExistence(timeout: waitTime) {
            doneButton.tap()
        } else {
            XCTFail("Element is Missing")
        }
        
        let calculateButton = app.buttons["calculate"]
        if calculateButton.waitForExistence(timeout: waitTime) {
            calculateButton.tap()
        } else {
            XCTFail("Element is Missing")
        }
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

//
//  ReverseWordsUITests.swift
//  ReverseWordsUITests
//
//  Created by Dmytro Ivanchuk on 26.07.2022.
//

import XCTest

class ViewControllerUITests: XCTestCase {
    
    let testString = "Test string."
    let reversedTestString = "tseT .gnirts"
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func test_returnOnKeybordPressed_withNonEmptyTextField_shouldReturnReversedString() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(!app.buttons["button"].isEnabled)
        
        app.textFields["textField"].tap()
        app.textFields["textField"].typeText(testString)
        XCTAssert(app.buttons["button"].isEnabled)
        
        app.keyboards.buttons["return"].tap()
        XCTAssert(app.staticTexts["reversedStringLabel"].label == reversedTestString)
        
        app.buttons["button"].tap()
        XCTAssert(!app.buttons["button"].isEnabled)
    }
    
    func test_reversedButtonPressed_withNonEmptyTextField_shouldReturnReversedString() throws {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(!app.buttons["button"].isEnabled)
        
        app.textFields["textField"].tap()
        app.textFields["textField"].typeText(testString)
        XCTAssert(app.buttons["button"].isEnabled)
        
        app.staticTexts["This application will reverse your words. Please type text below"].tap()
        app.buttons["button"].tap()
        XCTAssert(app.staticTexts["reversedStringLabel"].label == reversedTestString)
        
        app.buttons["button"].tap()
        XCTAssert(!app.buttons["button"].isEnabled)
    }
    
    func test_returnOnKeybordPressedAndReversedButtonPressed_withEmptyTextField_shouldReturnNothing() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["textField"].tap()
        app.keyboards.buttons["return"].tap()
        XCTAssert(!app.buttons["button"].isEnabled)
        
        app.textFields["textField"].typeText(testString)
        XCTAssert(app.buttons["button"].isEnabled)
        
        app.textFields["textField"].press(forDuration: 1.0)
        app.menuItems["Select All"].staticTexts["Select All"].tap()
        app.keyboards.keys["delete"].tap()
        app.staticTexts["This application will reverse your words. Please type text below"].tap()
        XCTAssert(!app.buttons["button"].isEnabled)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

//
//  ReverseWordsUITests.swift
//  ReverseWordsUITests
//
//  Created by Dmytro Ivanchuk on 26.07.2022.
//

import XCTest

class ViewControllerUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func test_defaultSegmentSelected_withNonEmptyTextField_shouldReturnReversedString() throws {
        
        func checkResultWithDefaultExclusion(for input: String, shouldReturn output: String) {
            let app = XCUIApplication()
            app.launch()
            XCTAssert(!app.buttons["button"].isEnabled)
            
            app.textFields["mainTextField"].tap()
            app.textFields["mainTextField"].typeText(input)
            XCTAssert(app.buttons["button"].isEnabled)
            XCTAssert(app.staticTexts["reversedStringLabel"].label == output)
            
            app.keyboards.buttons["return"].tap()
            app.buttons["button"].tap()
            XCTAssert(!app.buttons["button"].isEnabled)
        }
        
        checkResultWithDefaultExclusion(for: "Foxminded cool 24/7", shouldReturn: "dednimxoF looc 24/7")
        checkResultWithDefaultExclusion(for: "abcd efgh", shouldReturn: "dcba hgfe")
        checkResultWithDefaultExclusion(for: "a1bcd efg!h", shouldReturn: "d1cba hgf!e")
    }
    
    
    func test_customSegmentSelected_withNonEmptyTextField_shouldReturnReversedString() throws {
        
        func checkResultWithUserDefinedExclusion(for input: String, shouldReturn output: String) {
            let app = XCUIApplication()
            app.launch()
            XCTAssert(!app.buttons["button"].isEnabled)
            
            app.segmentedControls.buttons["Custom"].tap()
            app.textFields["mainTextField"].tap()
            app.textFields["mainTextField"].typeText(input)
            XCTAssert(app.buttons["button"].isEnabled)
            
            app.textFields["textToIgnoreTextField"].tap()
            app.textFields["textToIgnoreTextField"].typeText(exclusion)
            XCTAssert(app.staticTexts["reversedStringLabel"].label == output)
            
            app.keyboards.buttons["return"].tap()
            app.buttons["button"].tap()
            XCTAssert(!app.buttons["button"].isEnabled)
        }
        
        let exclusion = "xl"
        checkResultWithUserDefinedExclusion(for: "Foxminded cool 24/7", shouldReturn: "dexdnimoF oocl 7/42")
        checkResultWithUserDefinedExclusion(for: "abcd efgh", shouldReturn: "dcba hgfe")
        checkResultWithUserDefinedExclusion(for: "a1bcd efglh", shouldReturn: "dcb1a hgfle")
    }
    
    func test_returnOnKeybordPressedAndReversedButtonPressed_withEmptyTextField_shouldReturnNothing() throws {
        let app = XCUIApplication()
        app.launch()

        app.textFields["mainTextField"].tap()
        app.keyboards.buttons["return"].tap()
        XCTAssert(!app.buttons["button"].isEnabled)

        app.textFields["mainTextField"].typeText("Foxminded cool 24/7")
        XCTAssert(app.buttons["button"].isEnabled)
        XCTAssert(app.staticTexts["reversedStringLabel"].label == "dednimxoF looc 24/7")
        
        app.segmentedControls.buttons["Custom"].tap()
        app.textFields["textToIgnoreTextField"].tap()
        app.textFields["textToIgnoreTextField"].typeText("xl")
        XCTAssert(app.staticTexts["reversedStringLabel"].label == "dexdnimoF oocl 7/42")
        
        app.segmentedControls.buttons["Default"].tap()
        XCTAssert(app.staticTexts["reversedStringLabel"].label == "dednimxoF looc 24/7")
        
        app.textFields["mainTextField"].press(forDuration: 2.0)
        app.menuItems["Select All"].staticTexts["Select All"].tap()
        app.keyboards.keys["delete"].tap()
        app.staticTexts["This application will reverse your words.\nPlease type text below"].tap()
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

//
//  ReverseWordsUnitTests.swift
//  ReverseWordsUnitTests
//
//  Created by Dmytro Ivanchuk on 26.07.2022.
//

import XCTest
@testable import Reverse_Words

class StringModelUnitTests: XCTestCase {

    var stringModel: StringModel!
    
    override func setUpWithError() throws {
        stringModel = StringModel()
    }

    override func tearDownWithError() throws {
        stringModel = nil
    }
    
    func test_reverseString_withTestString_shouldReturnReversedString() throws {
        let reversedTestString = stringModel.reverseWords(in: "Test string")
        XCTAssert(reversedTestString == "tseT gnirts")
    }
    
    func test_reverseString_withNilString_shouldReturnReversedString() throws {
        let reversedNilString = stringModel.reverseWords(in: nil)
        XCTAssert(reversedNilString == "")
    }
    
    func test_reverseString_withRandomString_shouldReturnReversedString() throws {
        let reversedRandomString = stringModel.reverseWords(in: "Ostap Holub 1234567890 !@#$%^&*()-= 🇺🇦🇵🇱🇬🇧🇺🇸🇱🇹🇱🇻🇪🇪")
        
        XCTAssert(reversedRandomString == "patsO buloH 0987654321 =-)(*&^%$#@! 🇪🇪🇱🇻🇱🇹🇺🇸🇬🇧🇵🇱🇺🇦")
    }
}

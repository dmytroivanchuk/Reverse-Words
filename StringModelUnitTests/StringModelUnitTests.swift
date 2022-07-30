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
    
    func test_reverseString_withDefaultEsclusion_shouldReturnReversedString() throws {
        
        let reversedTestString1 = stringModel.reverseWords(in: "Foxminded cool 24/7")
        XCTAssert(reversedTestString1 == "dednimxoF looc 24/7")
        
        let reversedTestString2 = stringModel.reverseWords(in: "abcd efgh")
        XCTAssert(reversedTestString2 == "dcba hgfe")
        
        let reversedTestString3 = stringModel.reverseWords(in: "a1bcd efg!h")
        XCTAssert(reversedTestString3 == "d1cba hgf!e")
    }
    
    func test_reverseString_withUserDefinedExclusion_shouldReturnReversedString() throws {
        
        let reversedTestString1 = stringModel.reverseWords(in: "Foxminded cool 24/7", ignoring: "xl")
        XCTAssert(reversedTestString1 == "dexdnimoF oocl 7/42")
        
        let reversedTestString2 = stringModel.reverseWords(in: "abcd efgh", ignoring: "xl")
        XCTAssert(reversedTestString2 == "dcba hgfe")
        
        let reversedTestString3 = stringModel.reverseWords(in: "a1bcd efglh", ignoring: "xl")
        XCTAssert(reversedTestString3 == "dcb1a hgfle")
    }
    
    func test_reverseString_withRandomString_shouldReturnReversedString() throws {
        
        let reversedRandomString = stringModel.reverseWords(in: "Ostap Holub 1234567890 🇺🇦🇵🇱🇬🇧🇺🇸🇱🇹🇱🇻🇪🇪", ignoring: "🇺🇦")
        XCTAssert(reversedRandomString == "patsO buloH 0987654321 🇺🇦🇪🇪🇱🇻🇱🇹🇺🇸🇬🇧🇵🇱")
    }
}

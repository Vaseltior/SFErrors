//
// The MIT License (MIT)
//
// Copyright (c) 2015 Samuel GRAU
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//  SFErrors : SFErrorsTests.swift
//
//  Created by Samuel Grau on 01/03/2015.
//  Copyright (c) 2015 Samuel Grau. All rights reserved.
//
//

//  based on the work of David Owens II https://github.com/owensd/SwiftLib/

import UIKit
import XCTest

class SFErrorsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func failsForNegativeNumbers(value: Int) -> SFFailable {
        if value >= 0 {
            return .Success
        }
        else {
            return .Failure(SFError(code: value, domain: "SFFailabletests", userInfo: nil))
        }
    }
    
    func doubleValueUnlessNegative(value: Int) -> SFFailableOf<Int> {
        if value >= 0 {
            return SFFailableOf<Int>(value * 2)
            // should be: return .Success(value * 2)
        }
        else {
            return .Failure(SFError(code: value, domain: "SFFailabletests", userInfo: ["Message" : "Pick a positive number"]))
        }
    }
    
    func testBasicSFFailableUsageSuccess() {
        let response = failsForNegativeNumbers(1)
        XCTAssertFalse(response.failed)
    }
    
    func testBasicSFFailableUsageFailure() {
        let response = failsForNegativeNumbers(-123)
        XCTAssertTrue(response.failed)
        
        let error = response.error!
        XCTAssertEqual(error.code, -123)
        XCTAssertEqual(error.domain, "SFFailabletests")
        XCTAssertEqual(error.userInfo.count, 0)
    }
    
    func testBasicSFFailableOfUsageSuccess() {
        let response = doubleValueUnlessNegative(100)
        XCTAssertFalse(response.failed)
        XCTAssertEqual(response.value!, 200)
    }
    
    func testBasicSFFailableUsageOfFailure() {
        let response = doubleValueUnlessNegative(-13)
        XCTAssertTrue(response.failed)
        
        let error = response.error!
        XCTAssertEqual(error.code, -13)
        XCTAssertEqual(error.domain, "SFFailabletests")
        XCTAssertEqual(error.userInfo.count, 1)
        XCTAssertTrue(error.userInfo["Message"]! as String == "Pick a positive number")
    }
    
    func testDelayedValuesInSFFailableOf() {
        var value: Int = 0
        var result = SFFailableOf(value++)
        
        XCTAssertEqual(result.value!, 0)
        XCTAssertEqual(result.value!, 0)
        XCTAssertEqual(value, 1)
    }
    
}

//
//  WhatIsTheDose3Tests.swift
//  WhatIsTheDose3Tests
//
//  Created by Nils Norman Haukås on 02/05/2018.
//  Copyright © 2018 Nils Norman Haukås. All rights reserved.
//

import XCTest
@testable import WhatIsTheDose

class WhatIsTheDoseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testParseCommaText() {
        XCTAssert(Double("8,9".replacingOccurrences(of: ",", with: ".")) == 8.9, "Should have parsed text into float")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

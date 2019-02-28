//
//  UtilitiesTest.swift
//  Instabug_TaskTests
//
//  Created by Islam Soliman on 2/27/19.
//  Copyright © 2019 Islam Soliman. All rights reserved.
//

import XCTest
@testable import Instabug_Task

class UtilitiesTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFormattedTextFromDate() {
        
        let date = Date(timeIntervalSince1970: 0) // "Jan 1, 1970, 4:00 PM"

        
//        Calendar.date(fr)
        let text = Utilities.formattedText(fromDate: date)
        
        XCTAssert(text == "1970-01-01", "wrong date format \(text)")
    }
    
}

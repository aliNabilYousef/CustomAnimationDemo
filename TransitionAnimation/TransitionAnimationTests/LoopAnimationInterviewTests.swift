//
//  TransitionAnimationTests.swift
//  TransitionAnimationTests
//
//  Created by Ali Youssef on 4/22/22.
//

import XCTest
@testable import TransitionAnimation

class TransitionAnimationTests: XCTestCase {
    func test_data_set_count() {
        XCTAssertEqual(LPDataProvider.sharedInstance.dataSet.count, 11)
    }
    
    func test_data_set_value() {
        XCTAssertEqual(LPDataProvider.sharedInstance.dataSet[2].title, "Title 3")
        XCTAssertEqual(LPDataProvider.sharedInstance.dataSet[2].image, "3")
    }
    
    func test_data_set_strings_count() {
        XCTAssertEqual(LPDataProvider.sharedInstance.dataSetStrings.count, 6)
    }
    
    func test_data_set_strings_value() {
        XCTAssertEqual(LPDataProvider.sharedInstance.dataSetStrings[3], "9")
    }
    
    //Ideally I would liked to be able to test more than just static data that I filled
}

//
//  TransitionAnimationUITest.swift
//  TransitionAnimationUITest
//
//  Created by Ali Youssef on 4/28/22.
//

import XCTest

class TransitionAnimationUITest: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

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
    
    //I have a fucked up laptop, and the xcode crashes everytime i try to run this test or any UI related test, i wanted to do some UI unit testing but its not working atm and I don't have the luxury of fixing it atm 
    func testing_back_button_in_vc() {
        let app = XCUIApplication()
        app.launch()
        
        let backStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["back"]/*[[".buttons[\"back\"].staticTexts[\"back\"]",".staticTexts[\"back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertFalse(backStaticText.exists)
//        backStaticText.tap()
//        app/*@START_MENU_TOKEN@*/.staticTexts["News"]/*[[".buttons[\"News\"].staticTexts[\"News\"]",".staticTexts[\"News\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        backStaticText.tap()
//        app.buttons["Gallary"].tap()
//
//        let element = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
//        element.swipeLeft()
//        element.swipeLeft()
//        element.swipeRight()
//
          
        
    }
}

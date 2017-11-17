//
//  ExampleTests.swift
//  HinderAppTests
//
//  Created by Daniel Berestov on 11/16/17.
//  Copyright © 2017 TBD. All rights reserved.
//

import XCTest
@testable import HinderApp

class ExampleTests: XCTestCase {
    
    var controller:HomeViewController = HomeViewController()
    let menuClickedTextDisplayed : String = "Clicked menu"
    let settingsClickedTextDisplayed : String = "Clicked settings"
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(controller.menuClicked() == menuClickedTextDisplayed)
        XCTAssertTrue(controller.settingsClicked() == settingsClickedTextDisplayed)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

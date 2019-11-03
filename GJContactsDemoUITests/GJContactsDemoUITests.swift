//
//  GJContactsDemoUITests.swift
//  GJContactsDemoUITests
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest

class GJContactsDemoUITests: XCTestCase {
    
    private var application:XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    override func tearDown() {

    }

}

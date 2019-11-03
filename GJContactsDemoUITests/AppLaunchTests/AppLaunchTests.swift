//
//  AppLaunchTests.swift
//  GJContactsDemoUITests
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class AppLaunchTests: XCTestCase {

    private var application: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        application = XCUIApplication()
        application.launch()
    }

    override func tearDown() {
    }

    // test1: window's rootViewController should be a navigation controller
    // test2: navigation bar's tint color should be XXX
    // test3: navigation controller's initial view controller should be of ContactListViewController
    // test4: there should be only 1 viewcontroller with in navigation controller's viewcontroller upon launching
    func test_initialStates_upon_launching() {
        XCTAssertEqual(application.windows.count, 1)
    }

}

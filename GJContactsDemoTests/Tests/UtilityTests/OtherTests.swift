//
//  OtherTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class OtherTests: XCTestCase {
    
    func test_appLauncher_inititalViewController() {
        let initialViewController = AppLauncher.init().initialViewController()
        
        XCTAssertNotNil(initialViewController, "initial view controller should not be nil")
        XCTAssert(initialViewController.isKind(of: UINavigationController.self), "App launch initial view controller should be a navigation controller")
        
        let navigationController = initialViewController as! UINavigationController
        XCTAssertEqual(navigationController.viewControllers.count, 1, "There should be only one view controller in the navigation stack upon launching")
        XCTAssert(navigationController.viewControllers[0].isKind(of: ContactsListViewController.self), "first view controller in navigation stack should be ContactsListViewController's object")
    }

}

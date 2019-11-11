//
//  ContactEditVCTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactEditVCTests: XCTestCase {

    var mockEditModel:MockContactEditViewModel?
    
    override func setUp() {
        
    }

    override func tearDown() {

    }
    
    func testInit_And_ViewDidLoads() {
        
        mockEditModel = MockContactEditViewModel.init(Contact.init(1, firstName: "test", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: ""))
        let viewController = ContactEditViewController.initWithViewModel(mockEditModel!)
        viewController.loadView()
        viewController.viewDidLoad()

        let baritem1 = viewController.navigationItem.leftBarButtonItem
        XCTAssertEqual(baritem1?.title, "Cancel")
        
        let baritem2 = viewController.navigationItem.rightBarButtonItem
        XCTAssertEqual(baritem2?.title, "Done")
        
        viewController.showLoadingIndicator()
        viewController.hideLoadingIndicator()
        viewController.showStaticAlert("", message: "")
        viewController.showDoubleActionAlert("", message: nil, firstTitle: "", secondTitle: nil, onfirstClick: {}, onSecondClick: nil)
        XCTAssertNotNil(viewController.tableView)
    }
    
    func testButton_Actions()  {
        
        mockEditModel = MockContactEditViewModel.init(Contact.init(1, firstName: "test", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: ""))
        let viewController = ContactEditViewController.initWithViewModel(mockEditModel!)
        viewController.loadView()
        viewController.viewDidLoad()
        viewController.scrollViewWillBeginDragging(viewController.tableView)
        viewController.cancel_buttonAction()
        XCTAssertEqual(mockEditModel?.dismissViewInvoked, true)
        
        viewController.done_buttonAction()
        XCTAssertEqual(mockEditModel?.pushContactInvoked, true)
    }

}

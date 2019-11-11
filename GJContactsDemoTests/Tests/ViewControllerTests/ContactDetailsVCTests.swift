//
//  ContactDetailsVCTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactDetailsVCTests: XCTestCase {

    var mockDetailModel:MockContactDetailsViewModel?
    
    override func setUp() {
        
        mockDetailModel = MockContactDetailsViewModel.init(Contact.init(1, firstName: "firstName", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: ""))
    }

    override func tearDown() {
        
        mockDetailModel = nil
    }
    
    func testInit_And_ViewDidLoad() {
        
        let viewController = ContactDetailsViewController.initWithViewModel(mockDetailModel!)
        viewController.loadView()
        viewController.viewDidLoad()
        
        let baritem1 = viewController.navigationItem.leftBarButtonItem
        XCTAssertEqual(baritem1?.title, "Contact")
        
        let baritem2 = viewController.navigationItem.rightBarButtonItem
        XCTAssertEqual(baritem2?.title, "Edit")
        
        XCTAssertNotNil(viewController.profilePic_imgView)
    }
    
    func testButton_Actions()  {
        let viewController = ContactDetailsViewController.initWithViewModel(mockDetailModel!)
        viewController.loadView()
        viewController.viewDidLoad()
        
        viewController.edit_buttonAction()
        XCTAssertEqual(mockDetailModel?.isInvokeEditViewInvoked, true)

        viewController.back_buttonAction()
        XCTAssertEqual(mockDetailModel?.isDismissDetailView_invoked, true)
        
        viewController.message_buttonAction(sender: UIButton.init())
        XCTAssertEqual(mockDetailModel?.isTextMessage_invoked, true)

        viewController.hideLoadingIndicator()
        viewController.showStaticAlert("", message: "")
        viewController.phone_buttonAction(sender: UIButton.init())
        XCTAssertEqual(mockDetailModel?.ismakePhoneCall_invoked, true)

        viewController.email_buttonAction(sender: UIButton.init())
        XCTAssertEqual(mockDetailModel?.isInvokeEmail_invoked, true)
        
        viewController.favourite_buttonAction(sender: UIButton.init())
        XCTAssertEqual(mockDetailModel?.isMarkFavourite_invoked, true)
    }
}

//
//  ContactDetailViewModelTests2.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
import XCTest
@testable import GJContactsDemo

class ContactDetailViewModelTests2: XCTestCase {

    var detailVMProtocolStub:ContactDetailViewModelProtocol_StubClass!
    var contactDetailViewModel:ContactDetailViewModel!
    
    var invalidContact:Contact!
    var validContact:Contact!
    
    override func setUp() {
        
        invalidContact = Contact.init(id: 1101, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: nil, isFavorite: false, detailsUrl: nil, phoneNumber: "xi148y", email: "enfhekd", createDate: nil, lastUpdateDate: nil)
        
        validContact = Contact.init(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: nil, isFavorite: false, detailsUrl: nil, phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: nil, lastUpdateDate: nil)
        
        detailVMProtocolStub = ContactDetailViewModelProtocol_StubClass()
    }

    override func tearDown() {
        invalidContact = nil
        validContact = nil
        
        detailVMProtocolStub = nil
        contactDetailViewModel = nil
    }

    func testInvokeEmail_With_InvalidEmail() {
        contactDetailViewModel = ContactDetailViewModel(invalidContact)
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.invokeEmail()
        XCTAssertTrue(detailVMProtocolStub.showStaticAlert_invoked)
    }
    
    func testInvokeEmail_With_validEmail() {
        contactDetailViewModel = ContactDetailViewModel(validContact)
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.invokeEmail()
        XCTAssertFalse(detailVMProtocolStub.showStaticAlert_invoked)
    }
    
    func testPhoneCall_With_InvalidPhoneNumber() {
        contactDetailViewModel = ContactDetailViewModel(invalidContact)
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.makePhoneCall()
        XCTAssertTrue(detailVMProtocolStub.showStaticAlert_invoked)
    }
    
    func testPhoneCall_With_validPhoneNumber() {
        if TARGET_OS_SIMULATOR != 0 {
            return
        }
        else {
            contactDetailViewModel = ContactDetailViewModel(validContact)
            contactDetailViewModel.detailProtocol = detailVMProtocolStub
            
            contactDetailViewModel.makePhoneCall()
            XCTAssertFalse(detailVMProtocolStub.showStaticAlert_invoked)
        }
    }
    
    func testSMS_With_InvalidPhoneNumber() {
        contactDetailViewModel = ContactDetailViewModel(invalidContact)
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.textMessage()
        XCTAssertTrue(detailVMProtocolStub.showStaticAlert_invoked)
    }
    
    func testSMS_With_validPhoneNumber() {
        if TARGET_OS_SIMULATOR != 0 {
            return
        }
        contactDetailViewModel = ContactDetailViewModel(validContact)
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.textMessage()
        XCTAssertFalse(detailVMProtocolStub.showStaticAlert_invoked)
        
    }

}

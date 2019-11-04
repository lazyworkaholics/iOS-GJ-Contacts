//
//  ContactEditViewModelTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactEditViewModelTests: XCTestCase {

    var mockServiceManager:ServiceManagerMock!
    var editProtocolStub:ContactEditProtocol_StubClass!
    var editViewModel:ContactEditViewModel!
    
    override func setUp() {
        mockServiceManager = ServiceManagerMock()
        
        mockServiceManager.createContactService_contact = Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: "")
        
        mockServiceManager.createContact_error = NSError.init(domain: "com.testingErrorDomain",
                                                                 code: 11010101843834,
                                                                 userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        
        mockServiceManager.editContactService_contact = Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: "")
        
        mockServiceManager.editContact_error = NSError.init(domain: "com.testingErrorDomain",
                                                              code: 11010101843834,
                                                              userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        editProtocolStub = ContactEditProtocol_StubClass()
        editViewModel = ContactEditViewModel.init( Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
    }

    override func tearDown() {
        mockServiceManager = nil
        editProtocolStub = nil
        editViewModel = nil
    }
    
    func testloadDataCall() {
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.loadData()
        XCTAssertTrue(editProtocolStub.is_loadData_invoked, "load data fucntion in editViewModel is not invoking the view controllers load data")
    }
    
    func testCreateContact_FailFlow() {
        editViewModel = ContactEditViewModel.init(nil)

        mockServiceManager.is_createContact_Success = false
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.updateContact(Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        XCTAssertTrue(editProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertTrue(mockServiceManager.is_createContact_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertFalse(mockServiceManager.is_createContact_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertTrue(editProtocolStub.showStaticAlert_invoked)
        
    }
    
    func testCreateContact_SuccessFlow() {
        editViewModel = ContactEditViewModel.init(nil)
        
        mockServiceManager.is_createContact_Success = true
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.updateContact(Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        XCTAssertTrue(editProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertFalse(mockServiceManager.is_createContact_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertTrue(mockServiceManager.is_createContact_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertFalse(editProtocolStub.showStaticAlert_invoked)
    }
    
    func testeditContact_FailFlow() {
        mockServiceManager.is_editContact_Success = false
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.updateContact(Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98497897264", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        XCTAssertTrue(editProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertTrue(mockServiceManager.is_editContact_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertFalse(mockServiceManager.is_editContact_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertTrue(editProtocolStub.showStaticAlert_invoked)
        
    }
    
    func testeditContact_SuccessFlow() {
        mockServiceManager.is_editContact_Success = true
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.updateContact(Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98497897264", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        XCTAssertTrue(editProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertFalse(mockServiceManager.is_editContact_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertTrue(mockServiceManager.is_editContact_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertFalse(editProtocolStub.showStaticAlert_invoked)
    }

}

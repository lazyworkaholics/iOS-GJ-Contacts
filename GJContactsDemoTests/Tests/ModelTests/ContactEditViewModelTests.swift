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
    }

    override func tearDown() {
        mockServiceManager = nil
        editProtocolStub = nil
        editViewModel = nil
    }
    
    func testCreateContact_DismissFlow() {
        editViewModel = ContactEditViewModel.init(nil)
        
        mockServiceManager.is_createContact_Success = false
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.pushContact()
        
        XCTAssertFalse(editProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertFalse(mockServiceManager.is_createContact_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertFalse(mockServiceManager.is_createContact_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertFalse(editProtocolStub.showStaticAlert_invoked)
        
    }
    
    func testCreateContact_FailFlow() {
        editViewModel = ContactEditViewModel.init(nil)

        mockServiceManager.is_createContact_Success = false
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.dataUpdated(fieldName: "First Name", fieldValue: "Harsha")
        editViewModel.dataUpdated(fieldName: "Last Name", fieldValue: "Vardhan")
        editViewModel.pushContact()
        
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

        editViewModel.dataUpdated(fieldName: "First Name", fieldValue: "Harsha")
        editViewModel.dataUpdated(fieldName: "Last Name", fieldValue: "Vardhan")
        editViewModel.pushContact()
        
        XCTAssertTrue(editProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertFalse(mockServiceManager.is_createContact_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertTrue(mockServiceManager.is_createContact_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertFalse(editProtocolStub.showStaticAlert_invoked)
    }
    
    func testeditContact_FailFlow() {
        editViewModel = ContactEditViewModel.init( Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        mockServiceManager.is_editContact_Success = false
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.dataUpdated(fieldName: "mobile", fieldValue: "9849789625")
        editViewModel.dataUpdated(fieldName: "email", fieldValue: "harsha.pabbineedi@gmail.com")
        editViewModel.pushContact()
        
        XCTAssertTrue(editProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertTrue(mockServiceManager.is_editContact_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertFalse(mockServiceManager.is_editContact_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertTrue(editProtocolStub.showStaticAlert_invoked)
        
    }
    
    func testeditContact_SuccessFlow() {
        editViewModel = ContactEditViewModel.init( Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        mockServiceManager.is_editContact_Success = true
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.dataUpdated(fieldName: "mobile", fieldValue: "9849789625")
        editViewModel.dataUpdated(fieldName: "email", fieldValue: "harsha.pabbineedi@gmail.com")
        editViewModel.pushContact()
        
        XCTAssertTrue(editProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertFalse(mockServiceManager.is_editContact_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertTrue(mockServiceManager.is_editContact_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertFalse(editProtocolStub.showStaticAlert_invoked)
    }
    
    func testPopulateTableCell() {
        editViewModel = ContactEditViewModel.init( Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        XCTAssertEqual(editViewModel.populateTableCell(1)?.fieldValue, "Harsha", "First name should be harsha as per the above mock data")
        XCTAssertEqual(editViewModel.populateTableCell(2)?.fieldValue, "Vardhan", "Last name should be Vardhan as per the above mock data")
        XCTAssertEqual(editViewModel.populateTableCell(3)?.fieldValue, "98827533", "phone number should be 98827533 as per the above mock data")
        XCTAssertEqual(editViewModel.populateTableCell(4)?.fieldValue, "harsha.mvgr@gmail.com", "email should be harsha.mvgr@gmail.com as per the above mock data")
        XCTAssertEqual(editViewModel.populateTableCell(1)?.fieldName, "First Name", "First name should be the field name")
    }
    
    func testInputValidations_invalidName() {
        editViewModel = ContactEditViewModel.init( Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        mockServiceManager.is_editContact_Success = true
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.dataUpdated(fieldName: "First Name", fieldValue: "H")
        editViewModel.pushContact()
        
        XCTAssertTrue(editProtocolStub.showStaticAlert_invoked)
        XCTAssertEqual(editProtocolStub.showStaticAlert_Title, StringConstants.NAME_INVALID_TITLE, "Alert is not shown when user entered invalid name")
    }
    
    func testInputValidations_invalidPhoneNumber() {
        editViewModel = ContactEditViewModel.init( Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "98827533", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        mockServiceManager.is_editContact_Success = true
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.dataUpdated(fieldName: "mobile", fieldValue: "9")
        editViewModel.pushContact()
        XCTAssertEqual(editProtocolStub.showStaticAlert_Title, StringConstants.INVALID_PHONE_NUMBER, "Alert is not shown when user entered invalid phone number")
    }
    
    func testInputValidations_invalidEmail() {
        editViewModel = ContactEditViewModel.init( Contact(id: 1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "9882753311", email: "harsha.mvgr@gmail.com", createDate: "", lastUpdateDate: ""))
        
        mockServiceManager.is_editContact_Success = true
        editViewModel.serviceManager = mockServiceManager
        editViewModel.editProtocol = editProtocolStub
        
        editViewModel.dataUpdated(fieldName: "email", fieldValue: "ryrue")
        editViewModel.pushContact()
        XCTAssertEqual(editProtocolStub.showStaticAlert_Title, StringConstants.INVALID_EMAIL_ADDRESS, "Alert is not shown when user entered invalid email")
    }

}

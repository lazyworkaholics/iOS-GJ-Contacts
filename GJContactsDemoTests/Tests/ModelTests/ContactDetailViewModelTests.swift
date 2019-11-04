//
//  ContactDetailViewModelTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactDetailViewModelTests: XCTestCase {

    var mockServiceManager:ServiceManagerMock!
    var detailVMProtocolStub:ContactDetailViewModelProtocol_StubClass!
    var contactDetailViewModel:ContactDetailViewModel!
    
    var contact_before_serviceCall:Contact!
    var contact_after_serviceCall:Contact!
    
    override func setUp() {
        mockServiceManager = ServiceManagerMock.init()
        
        contact_before_serviceCall = Contact.init(id: 1101, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: nil, isFavorite: false, detailsUrl: nil, phoneNumber: "98827533", email: nil, createDate: nil, lastUpdateDate: nil)
        contact_after_serviceCall = Contact.init(id: 1101, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: nil, isFavorite: false, detailsUrl: nil, phoneNumber: nil, email: nil, createDate: nil, lastUpdateDate: nil)
        
        mockServiceManager.getContactDetail_contact = contact_before_serviceCall
        
        mockServiceManager.getContactDetail_error = NSError.init(domain: "com.testingErrorDomain",
                                                code: 11010101843834,
                                                userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        
        mockServiceManager.editContactService_contact = contact_before_serviceCall
        
        mockServiceManager.editContact_error = NSError.init(domain: "com.testingErrorDomain", code: 11010101843834, userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        
        mockServiceManager.deleteContact_error = NSError.init(domain: "com.testingErrorDomain", code: 11010101843834, userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        
        detailVMProtocolStub = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel = ContactDetailViewModel(contact_after_serviceCall)
    }

    override func tearDown() {
        mockServiceManager = nil
        detailVMProtocolStub = nil
        contactDetailViewModel = nil
    }

    func testLoadData_failureCase() {
        
        mockServiceManager.is_getContactDetail_Success = false
        contactDetailViewModel.serviceManager = mockServiceManager
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.loadData()
        
        XCTAssertTrue(detailVMProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertTrue(mockServiceManager.is_getContactDetail_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertFalse(mockServiceManager.is_getContactDetail_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertTrue(detailVMProtocolStub.showStaticAlert_invoked)
    }
    
    func testLoadData_successCase() {
        
        mockServiceManager.is_getContactDetail_Success = true
        contactDetailViewModel.serviceManager = mockServiceManager
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.loadData()
        
        XCTAssertTrue(detailVMProtocolStub.isShowLoadingIndicator_invoked, "show loading indicator is not fired")
        XCTAssertFalse(mockServiceManager.is_getContactDetail_FailureBlock_invoked, "Failure block is not invoked")
        XCTAssertTrue(mockServiceManager.is_getContactDetail_SuccessBlock_invoked, "Success block is invoked")
        XCTAssertFalse(detailVMProtocolStub.showStaticAlert_invoked)
    }
    
    func testInvokeEditContactView() {
        mockServiceManager.is_getContactDetail_Success = true
        contactDetailViewModel.serviceManager = mockServiceManager
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.invokeEditView()
        XCTAssertTrue(detailVMProtocolStub.is_routeToEditView_invoked)
    }
    
    func testMarkFavourite_failure() {
        mockServiceManager.is_editContact_Success =  false
        contactDetailViewModel.serviceManager = mockServiceManager
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.markFavourite(true)
        XCTAssertFalse(mockServiceManager.is_editContact_SuccessBlock_invoked)
        XCTAssertTrue(mockServiceManager.is_editContact_FailureBlock_invoked)
    }
    
    func testMarkFavourite_success() {
        mockServiceManager.is_editContact_Success = true
        contactDetailViewModel.serviceManager = mockServiceManager
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.markFavourite(false)
        XCTAssertTrue(mockServiceManager.is_editContact_SuccessBlock_invoked)
        XCTAssertFalse(mockServiceManager.is_editContact_FailureBlock_invoked)
    }
    
    
    
    func testDeleteContact_failure() {
        mockServiceManager.is_deleteContact_Success =  false
        contactDetailViewModel.serviceManager = mockServiceManager
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.delete()
        XCTAssertFalse(mockServiceManager.is_deleteContact_SuccessBlock_invoked)
        XCTAssertTrue(mockServiceManager.is_deleteContact_FailureBlock_invoked)
    }
    
    func testDelteContact_success() {
        mockServiceManager.is_deleteContact_Success = true
        contactDetailViewModel.serviceManager = mockServiceManager
        contactDetailViewModel.detailProtocol = detailVMProtocolStub
        
        contactDetailViewModel.delete()
        XCTAssertTrue(mockServiceManager.is_deleteContact_SuccessBlock_invoked)
        XCTAssertFalse(mockServiceManager.is_deleteContact_FailureBlock_invoked)
    }
    
    
}

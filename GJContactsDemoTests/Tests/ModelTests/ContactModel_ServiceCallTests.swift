//
//  ContactModel_ServiceCallTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 10/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactModel_ServiceCallTests: XCTestCase {
    
    var contact:Contact?
    var detailContact:Contact?
    var serviceError:NSError?
    var mockServiceManager:ServiceManagerMock?
    
    override func setUp() {
        contact = Contact.init(1101, firstName: "test_FirstName", lastName: "test_LastName", profilePicUrl: "", isFavorite: false, detailsUrl: "")
        
        detailContact = Contact.init(1101, firstName: "test_FirstName", lastName: "test_LastName", profilePicUrl: "testProfilePicURL", isFavorite: false, detailsUrl: "testDetailsUrl")
        
        serviceError = NSError.init(domain: "testDomain", code: 1000, userInfo: nil)
        
        mockServiceManager = ServiceManagerMock()
    }
    
    override func tearDown() {
        contact = nil
        mockServiceManager = nil
        detailContact = nil
        serviceError = nil
    }

    func testGetDetails_Success() {
        
        mockServiceManager!.getContactDetail_contact = detailContact
        mockServiceManager!.getContactDetail_error = nil
        mockServiceManager!.is_getContactDetail_Success = true
        contact?.serviceManager = mockServiceManager!
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, self.detailContact!, "contact details received different")
            XCTAssertEqual(error, nil, "error should be nil in success case")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactDetailsFetch)
            XCTAssertEqual(self.mockServiceManager?.is_getContactDetail_SuccessBlock_invoked, true)
            XCTAssertEqual(self.mockServiceManager?.is_getContactDetail_FailureBlock_invoked, false)
        })
        
        contact?.getDetails()
    }
    
    func testGetDetails_Failure() {
        
        mockServiceManager!.getContactDetail_error = serviceError
        mockServiceManager!.is_getContactDetail_Success = false
        contact?.serviceManager = mockServiceManager!
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, nil, "contact should be nil in failure case")
            XCTAssertEqual(error, self.serviceError, "error received different")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactDetailsFetch)
            XCTAssertEqual(self.mockServiceManager?.is_getContactDetail_SuccessBlock_invoked, false)
            XCTAssertEqual(self.mockServiceManager?.is_getContactDetail_FailureBlock_invoked, true)
        })
        
        contact?.getDetails()
    }
    
    func testPush_Success() {
        
        mockServiceManager!.editContactService_contact = detailContact
        mockServiceManager!.is_editContact_Success = true
        contact?.serviceManager = mockServiceManager!
        contact?.isContactModifiedLocally = true
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, self.detailContact, "contact details received different")
            XCTAssertEqual(error, nil, "error received different")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactUpdate)
            XCTAssertEqual(self.mockServiceManager?.is_editContact_SuccessBlock_invoked, true)
            XCTAssertEqual(self.mockServiceManager?.is_editContact_FailureBlock_invoked, false)
        })
        
        contact?.push(nil)
    }
    
    func testPush_noLocalChanges() {
        
        mockServiceManager!.editContactService_contact = detailContact
        mockServiceManager!.is_editContact_Success = true
        contact?.serviceManager = mockServiceManager!
        contact?.isContactModifiedLocally = false
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            let expectedError =  NSError.init(domain: Network_Error_Constants.LOCAL_ERROR_DOMAIN, code: Network_Error_Constants.EDIT_CONTACT_NOCHANGES_ERROR, userInfo: [NSLocalizedDescriptionKey: Network_Error_Constants.EDIT_CONTACT_NOCHANGES_LOCAL_DESCRIPTION])
            
            XCTAssertEqual(contact, nil, "contact should be nil in failure case")
            XCTAssertEqual(error, expectedError, "error received different")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactUpdate)
            XCTAssertEqual(self.mockServiceManager?.is_editContact_SuccessBlock_invoked, false)
            XCTAssertEqual(self.mockServiceManager?.is_editContact_FailureBlock_invoked, false)
        })
        
        contact?.push(nil)
    }
    
    func testPush_Failure() {
        
        mockServiceManager!.editContact_error = serviceError
        mockServiceManager!.is_editContact_Success = false
        contact?.serviceManager = mockServiceManager!
        contact?.isContactModifiedLocally = true
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, nil, "contact should be nil in failure case")
            XCTAssertEqual(error, self.serviceError, "error received different")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactUpdate)
            XCTAssertEqual(self.mockServiceManager?.is_editContact_SuccessBlock_invoked, false)
            XCTAssertEqual(self.mockServiceManager?.is_editContact_FailureBlock_invoked, true)
        })
        
        contact?.push(nil)
    }
    
    func testCreateContact_Success() {
        mockServiceManager!.createContactService_contact = self.detailContact
        mockServiceManager!.is_createContact_Success = true
        contact?.serviceManager = mockServiceManager!
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, self.detailContact, "contact received different")
            XCTAssertEqual(error, nil, "error should be nil in success case")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactCreate)
            XCTAssertEqual(self.mockServiceManager?.is_createContact_SuccessBlock_invoked, true)
            XCTAssertEqual(self.mockServiceManager?.is_createContact_FailureBlock_invoked, false)
        })
        
        contact?.create(nil)
    }
    
    func testCreateContact_Failure() {
        
        mockServiceManager!.createContact_error = self.serviceError
        mockServiceManager!.is_createContact_Success = false
        contact?.serviceManager = mockServiceManager!
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, nil, "contact received should be nil in failure case")
            XCTAssertEqual(error, self.serviceError, "error received different")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactCreate)
            XCTAssertEqual(self.mockServiceManager?.is_createContact_SuccessBlock_invoked, false)
            XCTAssertEqual(self.mockServiceManager?.is_createContact_FailureBlock_invoked, true)
        })
        
        contact?.create(nil)
    }
    
    func test_deleteContact_Success() {
        
        mockServiceManager!.is_deleteContact_Success = true
        contact?.serviceManager = mockServiceManager!
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, nil, "contact received should be nil in delete case")
            XCTAssertEqual(error, nil, "error should be nil in success case")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactDelete)
            XCTAssertEqual(self.mockServiceManager?.is_deleteContact_SuccessBlock_invoked, true)
            XCTAssertEqual(self.mockServiceManager?.is_deleteContact_FailureBlock_invoked, false)
        })
        
        contact?.delete()
    }
    
    func test_deleteContact_Failure() {
        
        mockServiceManager!.deleteContact_error = self.serviceError
        mockServiceManager!.is_deleteContact_Success = false
        contact?.serviceManager = mockServiceManager!
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, nil, "contact received should be nil in failure case")
            XCTAssertEqual(error, self.serviceError, "error is different")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ContactDelete)
            XCTAssertEqual(self.mockServiceManager?.is_deleteContact_SuccessBlock_invoked, false)
            XCTAssertEqual(self.mockServiceManager?.is_deleteContact_FailureBlock_invoked, true)
        })
        
        contact?.delete()
    }
}

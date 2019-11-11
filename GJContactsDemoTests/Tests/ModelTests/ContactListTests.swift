//
//  ContactListTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactListTests: XCTestCase {

    var contacts:[Contact] = []
    var serviceError:NSError?
    var mockServiceManager:ServiceManagerMock?
    
    override func setUp() {
        contacts = [Contact.init(1101, firstName: "test_FirstName", lastName: "test_LastName", profilePicUrl: "", isFavorite: false, detailsUrl: ""), Contact.init(1102, firstName: "test_FirstName2", lastName: "test_LastName2", profilePicUrl: "", isFavorite: false, detailsUrl: "")]

        serviceError = NSError.init(domain: "testDomain", code: 1000, userInfo: nil)
        mockServiceManager = ServiceManagerMock()
    }
    
    override func tearDown() {
        contacts = []
        mockServiceManager = nil
        serviceError = nil
    }
    
    func testContactList_fetch_Success() {
        
        mockServiceManager!.contacts = self.contacts
        mockServiceManager!.isSuccess = true
        
        let contactsList = ContactsList.init({ (contacts, serviceEvent) in
            XCTAssertEqual(contacts, self.contacts, "contacts received different")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ListFetch)
        }, errorObserver: { (error, serviceEvent) in
            XCTFail()
        })
        
        contactsList.serviceManager = mockServiceManager!
        contactsList.fetch()
    }
    
    func testContactList_fetch_failure() {
        
        mockServiceManager!.error = self.serviceError
        mockServiceManager!.isSuccess = false
        
        let contactsList = ContactsList.init({ (contacts, serviceEvent) in
            XCTFail()
            
        }, errorObserver: { (error, serviceEvent) in
            
            XCTAssertEqual(error, self.serviceError, "error received different")
            XCTAssertEqual(serviceEvent, ContactServiceEvent.ListFetch)
        })
        
        contactsList.serviceManager = mockServiceManager!
        contactsList.fetch()
    }

}

//
//  ContactModelTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactModelTests: XCTestCase {
    
    func testGetFullName_with_valid_first_last_names() {
        let contact = Contact.init(1101, firstName: "test_FirstName", lastName: "test_LastName", profilePicUrl: "", isFavorite: false, detailsUrl: "")
        XCTAssertEqual(contact.fullName, "test_FirstName test_LastName", "contact full name returned error")
    }
    
    func testGetFullName_with_nil_first_and_valid_last_names() {
        let contact = Contact.init(1101, firstName: "", lastName: "test_FirstName", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "")
        XCTAssertEqual(contact.fullName, "test_FirstName", "contact full name returned error")
    }
    
    func testGetFullName_with_valid_first_andlast_names() {
        let contact = Contact.init(1101, firstName: "", lastName: "", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "")
        XCTAssertEqual(contact.fullName, "", "contact full name returned error")
    }
    
    func testNotEqualElementsComparision() {
        
        let contact1 = Contact.init(1101, firstName: "", lastName: "", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "")
        
        let contact2 = Contact.init(1102, firstName: "", lastName: "", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "")
        
        if contact1 != contact2 {
            XCTAssert(true)
        }
        else {
            XCTFail()
        }
        
        if contact1 == contact2 {
            XCTFail()
        }
        else {
            XCTAssert(true)
        }
    }
    
    func testEqualElementsComparision() {
        
        let contact1 = Contact.init(1101, firstName: "", lastName: "", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "")
        
        let contact2 = Contact.init(1101, firstName: "", lastName: "", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "")
        
        if contact1 == contact2 {
            XCTAssert(true)
        }
        else {
            XCTFail()
        }
        
        if contact1 != contact2 {
            XCTFail()
        }
        else {
            XCTAssert(true)
        }
    }
}

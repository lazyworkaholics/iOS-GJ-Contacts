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
        let contact = Contact.init(id: 1101, firstName: "test_FirstName", lastName: "test_LastName", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "", phoneNumber: "", email: "", createDate: "", lastUpdateDate: "")
        XCTAssertEqual(contact.fullName, "test_FirstName test_LastName", "contact full name returned error")
    }
    
    func testGetFullName_with_nil_first_and_valid_last_names() {
        let contact = Contact.init(id: 1101, firstName: "", lastName: "test_FirstName", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "", phoneNumber: "", email: "", createDate: "", lastUpdateDate: "")
        XCTAssertEqual(contact.fullName, "test_FirstName", "contact full name returned error")
    }
    
    func testGetFullName_with_valid_first_andlast_names() {
        let contact = Contact.init(id: 1101, firstName: "", lastName: "", profilePicUrl: "profilePicURL", isFavorite: false, detailsUrl: "", phoneNumber: "", email: "", createDate: "", lastUpdateDate: "")
        XCTAssertEqual(contact.fullName, "", "contact full name returned error")
    }

}

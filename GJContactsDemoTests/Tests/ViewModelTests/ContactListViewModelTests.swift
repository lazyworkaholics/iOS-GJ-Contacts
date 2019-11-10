//
//  ContactListViewModelTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactListViewModelTests: XCTestCase {
    
    var contacts:[Contact]?
    var serviceError:NSError?
    
    override func setUp() {
        
        contacts = [
            Contact.init(1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl:
                "", isFavorite: false, detailsUrl: ""),
            
            Contact.init(1103, firstName: "Abhishek", lastName: "Rastogi", profilePicUrl: "", isFavorite: false, detailsUrl: ""),
            
            Contact.init(1104, firstName: "Henry", lastName: "Williams", profilePicUrl: "", isFavorite: false, detailsUrl: "")]
        
        serviceError = NSError.init(domain: "com.testingErrorDomain",
                                    code: 11010101843834,
                                    userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
    }

    override func tearDown() {
        contacts = nil
        serviceError = nil
    }
    
    func test_fetch_With_Failure() {
        let mockContactsList =  MockContactsList.init( {
            (contacts_mock, serviceEvent_mock) in
            
            XCTFail()
        }, errorObserver: {
            (error_mock, serviceEvent_mock) in
          
            XCTAssert(true)
        })
        
        let listViewProtocolStub = ContactListViewModelProtocol_StubClass()
        
        let contactlistViewModel = ContactsListViewModel.init()
        contactlistViewModel.listProtocol = listViewProtocolStub
        
        mockContactsList.isFetchSuccess = false
        mockContactsList.fetch_error = serviceError
        contactlistViewModel.dataSource = mockContactsList
        contactlistViewModel.fetch()
        
        // application should go into failure case but not success case
        XCTAssertTrue(mockContactsList.is_fetch_failureBlock_invoked!, "Failure block is not invoked")
        XCTAssertFalse(mockContactsList.is_fetch_successBlock_invoked!, "Success block is invoked")
    }
    
    func test_fetch_With_Success_AndUpdateResults() {
        let mockContactsList =  MockContactsList.init( {
            (contacts_mock, serviceEvent_mock) in
            
            XCTAssertEqual(contacts_mock, self.contacts, "data mismatched")
            XCTAssertEqual(serviceEvent_mock, ContactServiceEvent.ListFetch, "data mismatched")
        }, errorObserver: {
            (error_mock, serviceEvent_mock) in
            
            XCTFail()
        })
        
        let listViewProtocolStub = ContactListViewModelProtocol_StubClass()
        
        let contactlistViewModel = ContactsListViewModel.init()
        contactlistViewModel.listProtocol = listViewProtocolStub
        
        mockContactsList.isFetchSuccess = true
        mockContactsList.fetch_Contacts = contacts
        contactlistViewModel.dataSource = mockContactsList
        contactlistViewModel.fetch()
        
        contactlistViewModel.updateResults(with: "Ha", isSearchEnabled: true)
        contactlistViewModel.updateResults(with: "", isSearchEnabled: true)
        contactlistViewModel.updateResults(with: "", isSearchEnabled: false)
        contactlistViewModel.invokeAddView()
        
        // application should go into failure case but not success case
        XCTAssertFalse(mockContactsList.is_fetch_failureBlock_invoked!, "Failure block is not invoked")
        XCTAssertTrue(mockContactsList.is_fetch_successBlock_invoked!, "Success block is invoked")
    }
    
    func test_TableViewHandlerFunctions() {
        let mockContactsList =  MockContactsList.init( {
            (contacts_mock, serviceEvent_mock) in
            
            XCTAssertEqual(contacts_mock, self.contacts, "data mismatched")
            XCTAssertEqual(serviceEvent_mock, ContactServiceEvent.ListFetch, "data mismatched")
        }, errorObserver: {
            (error_mock, serviceEvent_mock) in
            
            XCTFail()
        })
        let contactlistViewModel = ContactsListViewModel.init()
        contactlistViewModel.dataSource = mockContactsList
        contactlistViewModel.dataSource?.contacts = self.contacts!
        contactlistViewModel.updateResults(with: "", isSearchEnabled: false)
        contactlistViewModel.invokeDetailView(IndexPath.init(row: 0, section: 0))
        
        let count = contactlistViewModel.getSectionCount()
        XCTAssertEqual(count, 2, "the given mock data should return count as 2 here")
        
        XCTAssertEqual(contactlistViewModel.getRowCount(for: 0), 1, "the give mock data should return count as 1 here")
        XCTAssertEqual(contactlistViewModel.getRowCount(for: 1), 2, "the give mock data should return count as 2 here")
    }
    
    func test_viewMode_TableViewHandler_MoreTests() {
        
        let mockContactsList =  MockContactsList.init( {
            (contacts_mock, serviceEvent_mock) in
            
            XCTAssertEqual(contacts_mock, self.contacts, "data mismatched")
            XCTAssertEqual(serviceEvent_mock, ContactServiceEvent.ListFetch, "data mismatched")
        }, errorObserver: {
            (error_mock, serviceEvent_mock) in
            
            XCTFail()
        })
        let contactlistViewModel = ContactsListViewModel.init()
        contactlistViewModel.dataSource = mockContactsList
        contactlistViewModel.dataSource?.contacts = self.contacts!
        contactlistViewModel.updateResults(with: "", isSearchEnabled: false)
        
        let mockContact_Section1_Row0 = Contact.init(1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "")
        
        let resultContact = contactlistViewModel.getContact(for: IndexPath.init(row: 0, section: 1))
        XCTAssertEqual(mockContact_Section1_Row0, resultContact, "getContact function is not working as expected")
        
        let sectionTitles = contactlistViewModel.getSectionTitles()
        XCTAssertEqual(["A","H"], sectionTitles, "getSectionTitles function is not working as expected")
        
        XCTAssertEqual("A", contactlistViewModel.getSectionHeaderTitle(section: 0), "getSectionHeaderTitle function is not working as expected")
    }
    
    func test_viewMode_TableViewHandler_MoreTests1() {
        
        let mockContactsList =  MockContactsList.init( {
            (contacts_mock, serviceEvent_mock) in
            
            XCTAssertEqual(contacts_mock, self.contacts, "data mismatched")
            XCTAssertEqual(serviceEvent_mock, ContactServiceEvent.ListFetch, "data mismatched")
        }, errorObserver: {
            (error_mock, serviceEvent_mock) in
            
            XCTFail()
        })
        let contactlistViewModel = ContactsListViewModel.init()
        contactlistViewModel.dataSource = mockContactsList
        contactlistViewModel.dataSource?.contacts = self.contacts!
        
        contactlistViewModel.updateResults(with: "Ha", isSearchEnabled: true)
        contactlistViewModel.updateResults(with: "", isSearchEnabled: false)
        
        let count = contactlistViewModel.getSectionCount()
        XCTAssertEqual(count, 2, "the given mock data should return count as 2 here")
        
        XCTAssertEqual(contactlistViewModel.getRowCount(for: 0), 1, "the give mock data should return count as 1 here")
        XCTAssertEqual(contactlistViewModel.getRowCount(for: 1), 2, "the give mock data should return count as 2 here")
        
        let mockContact_Section1_Row0 = Contact.init(1102, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "")
        
        let resultContact = contactlistViewModel.getContact(for: IndexPath.init(row: 0, section: 1))
        XCTAssertEqual(mockContact_Section1_Row0, resultContact, "getContact function is not working as expected")
        
        let sectionTitles = contactlistViewModel.getSectionTitles()
        XCTAssertEqual(["A","H"], sectionTitles, "getSectionTitles function is not working as expected")
        
        XCTAssertEqual("A", contactlistViewModel.getSectionHeaderTitle(section: 0), "getSectionHeaderTitle function is not working as expected")
    }
}

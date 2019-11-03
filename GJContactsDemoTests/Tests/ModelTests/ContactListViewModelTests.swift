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
    
    var mockServiceManager:ServiceManagerMock!

    override func setUp() {
        mockServiceManager = ServiceManagerMock.init()
        
        mockServiceManager.contacts = [Contact.init(id: 1101, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: nil, isFavorite: false, detailsUrl: nil, phoneNumber: nil, email: nil, createDate: nil, lastUpdateDate: nil), Contact.init(id: 1102, firstName: "Abhishek", lastName: "Rastogi", profilePicUrl: nil, isFavorite: false, detailsUrl: nil, phoneNumber: nil, email: nil, createDate: nil, lastUpdateDate: nil),Contact.init(id: 1103, firstName: "Henry", lastName: "Williams", profilePicUrl: nil, isFavorite: false, detailsUrl: nil, phoneNumber: nil, email: nil, createDate: nil, lastUpdateDate: nil)]
        
        mockServiceManager.error = NSError.init(domain: "com.testingErrorDomain",
                                                code: 11010101843834,
                                                userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
    }

    override func tearDown() {
        mockServiceManager = nil
    }
    
    func testviewController_Loading_WithFailureCase() {
        let listViewProtocolStub = ContactListViewModelProtocol_StubClass()
        
        let contactlistViewModel = ContactsListViewModel()
        mockServiceManager.isSuccess = false
        
        contactlistViewModel.serviceManager = mockServiceManager
        contactlistViewModel.listProtocol = listViewProtocolStub
        
        contactlistViewModel.viewControllerLoaded()
        
        // on function invoke, listProtocol's showLoadingIndicator should be called
        XCTAssertTrue(listViewProtocolStub.isShowLoadingIndicator_involed, "show loading indicator is not fired")
        
        // application should go into failure case but not success case
        XCTAssertTrue(mockServiceManager.isFailureBlock_invoke, "Failure block is not invoked")
        XCTAssertFalse(mockServiceManager.isSuccessBlock_invoked, "Success block is not invoked")
        
        // listProtocol's showStaticAlert with message as mock error's localized description
        XCTAssertTrue(listViewProtocolStub.showStaticAlert_involed)
    }
    
    func testviewController_Loading_WithSuccessCase() {
        let listViewProtocolStub = ContactListViewModelProtocol_StubClass()
        
        let contactlistViewModel = ContactsListViewModel()
        mockServiceManager.isSuccess = true
        
        contactlistViewModel.serviceManager = mockServiceManager
        contactlistViewModel.listProtocol = listViewProtocolStub
        
        contactlistViewModel.viewControllerLoaded()
        
        // on function invoke, listProtocol's showLoadingIndicator should be called
        XCTAssertTrue(listViewProtocolStub.isShowLoadingIndicator_involed, "show loading indicator is not fired")
        
        // application should go into failure case but not success case
        XCTAssertFalse(mockServiceManager.isFailureBlock_invoke, "Failure block is not invoked")
        XCTAssertTrue(mockServiceManager.isSuccessBlock_invoked, "Success block is not invoked")
        
        // listProtocol's showStaticAlert with message as mock error's localized description
        XCTAssertTrue(listViewProtocolStub.reloadTableView_involed)
        XCTAssertTrue(listViewProtocolStub.isHideLoadingIndicator_involed)
    }
    
    func test_viewModel_TableViewHandlerTests() {
        let listViewProtocolStub = ContactListViewModelProtocol_StubClass()
        
        let contactlistViewModel = ContactsListViewModel()
        mockServiceManager.isSuccess = true
        
        contactlistViewModel.serviceManager = mockServiceManager
        contactlistViewModel.listProtocol = listViewProtocolStub
        
        contactlistViewModel.viewControllerLoaded()
        
        let count = contactlistViewModel.getSectionCount()
        XCTAssertEqual(count, 2, "the given mock data should return count as 2 here")
        
        XCTAssertEqual(contactlistViewModel.getRowCount(for: 0), 1, "the give mock data should return count as 1 here")
        XCTAssertEqual(contactlistViewModel.getRowCount(for: 1), 2, "the give mock data should return count as 2 here")
    }
    
    func test_viewMode_TableViewHandler_MoreTests() {
        let listViewProtocolStub = ContactListViewModelProtocol_StubClass()
        
        let contactlistViewModel = ContactsListViewModel()
        mockServiceManager.isSuccess = true
        
        contactlistViewModel.serviceManager = mockServiceManager
        contactlistViewModel.listProtocol = listViewProtocolStub
        
        contactlistViewModel.viewControllerLoaded()
        
        let mockContact_Section1_Row0 = Contact.init(id: 1101, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: nil, isFavorite: false, detailsUrl: nil, phoneNumber: nil, email: nil, createDate: nil, lastUpdateDate: nil)
        
        let resultContact = contactlistViewModel.getContact(for: IndexPath.init(row: 0, section: 1))
        XCTAssertEqual(mockContact_Section1_Row0, resultContact, "getContact function is not working as expected")
        
        let sectionTitles = contactlistViewModel.getSectionTitles()
        XCTAssertEqual(["A","H"], sectionTitles, "getSectionTitles function is not working as expected")
        
        XCTAssertEqual("A", contactlistViewModel.getSectionHeaderTitle(section: 0), "getSectionHeaderTitle function is not working as expected")
    }

}

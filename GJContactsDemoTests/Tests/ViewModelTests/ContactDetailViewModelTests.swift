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
    
    var mockserviceManager:ServiceManagerMock?
    var contact:Contact?
    var contact_detailed:Contact?
    var serviceError:NSError?
    
    override func setUp() {
        mockserviceManager = ServiceManagerMock()
        contact = Contact.init(1101, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "", isFavorite: false, detailsUrl: "")
        serviceError = NSError.init(domain: "com.testingErrorDomain",
                                    code: 11010101843834,
                                    userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        contact_detailed = Contact.init(1101, firstName: "Harsha", lastName: "Vardhan", profilePicUrl: "test", isFavorite: false, detailsUrl: "")
    }

    override func tearDown() {
        mockserviceManager = nil
        contact = nil
        serviceError = nil
        contact_detailed = nil
    }
    
    func testLoadData_successCase() {
        
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, self.contact_detailed!, "contact received is mismatched")
        })
        mockserviceManager!.is_getContactDetail_Success = true
        mockserviceManager!.getContactDetail_contact = contact_detailed
        
        contact?.serviceManager = self.mockserviceManager!
        
        let contactDetailViewModel = ContactDetailViewModel.init(contact!)
        let detailProtocol = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel.detailProtocol = detailProtocol
        contactDetailViewModel.fetch()
        
        XCTAssertEqual(detailProtocol.isShowLoadingIndicator_invoked, true)
        XCTAssertEqual(detailProtocol.is_loadData_invoked, true)
    }
    
    func testLoadData_failureCase() {
        contact?.contactObserver = ({
            (contact, error, serviceEvent) -> Void in
            
            XCTAssertEqual(contact, nil, "contact received is mismatched")
        })
        mockserviceManager!.is_getContactDetail_Success = false
        mockserviceManager!.getContactDetail_error = self.serviceError
        
        contact?.serviceManager = self.mockserviceManager!
        
        let contactDetailViewModel = ContactDetailViewModel.init(contact!)
        let detailProtocol = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel.detailProtocol = detailProtocol
        contactDetailViewModel.fetch()
        
        XCTAssertEqual(detailProtocol.isShowLoadingIndicator_invoked, true)
        XCTAssertEqual(detailProtocol.is_loadData_invoked, true)
    }
    
    func testContactObserver_whenError() {
        
        let contactDetailViewModel = ContactDetailViewModel.init(contact!)
        let detailProtocol = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel.detailProtocol = detailProtocol
        contactDetailViewModel.contactObserver(nil, serviceError, .ContactDelete)
        
        XCTAssertEqual(detailProtocol.showStaticAlert_invoked, true)
    }
    
    func testContactObserver_Delete_Success() {
        let routerMock = RouterMock.init()
        let contactDetailViewModel = ContactDetailViewModel.init(contact!)
        
        let detailProtocol = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel.detailProtocol = detailProtocol
        contactDetailViewModel.router = routerMock
        contactDetailViewModel.contactObserver(nil, nil, .ContactDelete)
        
        XCTAssertEqual(routerMock.ispopDetailView_called, true)
    }
    
    func testContactObserver_DetailFetch_Success() {
        let routerMock = RouterMock.init()
        let contactDetailViewModel = ContactDetailViewModel.init(contact!)
        
        let detailProtocol = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel.detailProtocol = detailProtocol
        contactDetailViewModel.router = routerMock
        contactDetailViewModel.contactObserver(contact_detailed, nil, .ContactDetailsFetch)
        
        XCTAssertEqual(detailProtocol.is_loadData_invoked, true)
        XCTAssertEqual(detailProtocol.isHideLoadingIndicator_invoked, true)
    }
    
    func testContactObserver_others() {
        let routerMock = RouterMock.init()
        let contactDetailViewModel = ContactDetailViewModel.init(contact!)
        
        let detailProtocol = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel.detailProtocol = detailProtocol
        contactDetailViewModel.router = routerMock
        contactDetailViewModel.contactObserver(nil, nil, .ContactCreate)
        
        XCTAssertEqual(detailProtocol.isHideLoadingIndicator_invoked, true)
    }
    
    func testInvokeEditView() {
        let routerMock = RouterMock.init()
        let contactDetailViewModel = ContactDetailViewModel.init(contact!)
        contactDetailViewModel.router = routerMock
        contactDetailViewModel.invokeEditView()
        XCTAssertEqual(routerMock.islaunchEditView_called, true)
    }
    
    func testDismissDetailView() {
        let routerMock = RouterMock.init()
        let contactDetailViewModel = ContactDetailViewModel.init(contact!)
        contactDetailViewModel.router = routerMock
        contactDetailViewModel.dismissDetailView()
        XCTAssertEqual(routerMock.ispopDetailView_called, true)
    }
    
    func testMarkFavourite() {
        let mockContact = MockContact.init(1101, firstName: "", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: "")
        let contactDetailViewModel = ContactDetailViewModel.init(mockContact)
        
        let detailProtocol = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel.detailProtocol = detailProtocol
        contactDetailViewModel.markFavourite(true)
        XCTAssertEqual(detailProtocol.isShowLoadingIndicator_invoked, true)
    }
    
    func testDelete() {
        let mockContact = MockContact.init(1101, firstName: "", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: "")
        let contactDetailViewModel = ContactDetailViewModel.init(mockContact)
        
        let detailProtocol = ContactDetailViewModelProtocol_StubClass()
        contactDetailViewModel.detailProtocol = detailProtocol
        contactDetailViewModel.delete()
        XCTAssertEqual(detailProtocol.isShowLoadingIndicator_invoked, true)
    }
}

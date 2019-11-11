//
//  ContactsListVCTests.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import XCTest
@testable import GJContactsDemo

class ContactsListVCTests: XCTestCase {

    var mockViewModel:MockContactsListViewModel?
    
    override func setUp() {

        mockViewModel = MockContactsListViewModel.init()
    }

    override func tearDown() {
        mockViewModel = nil
    }
    
    func testViewController_init() {
    
        let viewController = ContactsListViewController.initWithViewModel(mockViewModel!)
        XCTAssertNotNil(viewController)
    }
    
    func testViewController_viewDidLoad() {
        
        let viewController = ContactsListViewController.initWithViewModel(mockViewModel!)
        viewController.viewDidLoad()
        
        // view controller's navigation item should have a left bar button item with groups name
        let baritem1 = viewController.navigationItem.leftBarButtonItem
        XCTAssertEqual(baritem1?.title, "Groups")
        
        // view controller's navigation item should have a right bar button item with +
        let baritem2 = viewController.navigationItem.rightBarButtonItem
        XCTAssertNotNil(baritem2)
        
        // view controller's navigation item should have a search controller attached.
        let searchController = viewController.navigationItem.searchController
        XCTAssertNotNil(searchController)
    }
    
    func testInvoke_addView() {
        let contactsList = ContactsList.init({ (contact, ServiceEvent) in
            
        }, errorObserver: { (error, ServiceEvent) in
            
        })
        
        contactsList.contacts = [
            Contact.init(1, firstName:"A", lastName:"A", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(2, firstName:"A", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(3, firstName:"B", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(4, firstName:"C", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
        ]
        mockViewModel?.injectMockData(contactsList, searchString: "")
        
        let viewController = ContactsListViewController.initWithViewModel(mockViewModel!)
        viewController.loadView()
        
        viewController.add_buttonAction()
        viewController.groups_buttonAction()
        viewController.hideLoadingIndicator()
        viewController.showStaticAlert("test", message: "")
        XCTAssertEqual(mockViewModel?.isAddViewInvoked, true)
    }
    
    func testTableView_DataSources_WithMockData()  {
        let contactsList = ContactsList.init({ (contact, ServiceEvent) in
            
        }, errorObserver: { (error, ServiceEvent) in
            
        })
        
        contactsList.contacts = [
            Contact.init(1, firstName:"A", lastName:"A", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(2, firstName:"A", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(3, firstName:"B", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(4, firstName:"C", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
        ]
        mockViewModel?.injectMockData(contactsList, searchString: "")

        let viewController = ContactsListViewController.initWithViewModel(mockViewModel!)
        viewController.loadView()
        
        let sectionCount = viewController.numberOfSections(in: viewController.tableView)
        XCTAssertEqual(sectionCount, 3)
        
        let rowCount = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, 2)
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath.init(row: 0, section: 1))
        XCTAssertTrue(cell.isKind(of: ListTableViewCell.self))
        
        let listCell = cell as! ListTableViewCell
        XCTAssertEqual(listCell.name_lbl.text, "B A1")
        
        let sectionTitles = viewController.sectionIndexTitles(for: viewController.tableView)
        XCTAssertEqual(sectionTitles, ["A", "B", "C"])
        
        XCTAssertEqual(viewController.tableView(viewController.tableView, heightForHeaderInSection: 0), 36)
        
        let headerView = viewController.tableView(viewController.tableView, viewForHeaderInSection: 0)
        XCTAssertNotNil(headerView)
    }
    
    func testTableView_Delegate_WithMockData()  {
        
        let contactsList = ContactsList.init({ (contact, ServiceEvent) in
            
        }, errorObserver: { (error, ServiceEvent) in
            
        })
        
        contactsList.contacts = [
            Contact.init(1, firstName:"A", lastName:"A", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(2, firstName:"A", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(3, firstName:"B", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(4, firstName:"C", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
        ]
        mockViewModel?.injectMockData(contactsList, searchString: "")
        
        let viewController = ContactsListViewController.initWithViewModel(mockViewModel!)
        viewController.loadView()
        
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
        
        XCTAssertEqual(mockViewModel?.invokedDetailViewIndexPath, IndexPath.init(row: 0, section: 0))
        XCTAssertEqual(mockViewModel?.isDetailViewInvoked, true)
    }
    
    func testSearchResults() {
        let contactsList = ContactsList.init({ (contact, ServiceEvent) in
            
        }, errorObserver: { (error, ServiceEvent) in
            
        })
        
        contactsList.contacts = [
            Contact.init(1, firstName:"A", lastName:"A", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(2, firstName:"A", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(3, firstName:"B", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
            Contact.init(4, firstName:"C", lastName:"A1", profilePicUrl:"", isFavorite:false, detailsUrl:""),
        ]
        mockViewModel?.injectMockData(contactsList, searchString: "")
        
        let viewController = ContactsListViewController.initWithViewModel(mockViewModel!)
        viewController.loadView()
        viewController.viewDidLoad()
        
        viewController.updateSearchResults(for: viewController.searchController)
        XCTAssertEqual(mockViewModel?.isupdateResultsInvoked, true)
        
        viewController.didDismissSearchController(viewController.searchController)
        XCTAssertEqual(mockViewModel?.isupdateResultsInvoked, true)
    }
}

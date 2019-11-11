//
//  MockContactsListViewModel.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
@testable import GJContactsDemo

class MockContactsListViewModel: ContactsListViewModel {
    
    var isDetailViewInvoked = false
    var invokedDetailViewIndexPath:IndexPath?
    
    var isAddViewInvoked = false
    var isupdateResultsInvoked = false
    
    func injectMockData(_ contacts:ContactsList, searchString:String) {
        
        self.dataSource = contacts
        self.updateResults(with: searchString, isSearchEnabled: searchString != "" ? true:false)
    }
    
    override func invokeDetailView(_ indexPath: IndexPath) {
        invokedDetailViewIndexPath = indexPath
        isDetailViewInvoked = true
    }
    
    override func invokeAddView() {
        isAddViewInvoked = true
    }
    
    override func updateResults(with searchString: String, isSearchEnabled: Bool) {
        isupdateResultsInvoked = true
        super.updateResults(with: searchString, isSearchEnabled: true)
    }
}

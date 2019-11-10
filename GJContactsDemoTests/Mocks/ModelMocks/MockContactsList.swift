//
//  MockContactsList.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit
@testable import GJContactsDemo

class MockContactsList: ContactsList {
    
    var isFetchSuccess:Bool?
    var fetch_Contacts:[Contact]?
    var fetch_error:NSError?
    
    var is_fetch_successBlock_invoked:Bool?
    var is_fetch_failureBlock_invoked:Bool?

    override func fetch() {
        
        if isFetchSuccess! {
            is_fetch_successBlock_invoked = true
            is_fetch_failureBlock_invoked = false
            self.contactListObserver?(fetch_Contacts!, ContactServiceEvent.ListFetch)
        }
        else {
            is_fetch_failureBlock_invoked = true
            is_fetch_successBlock_invoked = false
            self.errorObserver?(fetch_error!, ContactServiceEvent.ListFetch)
        }
    }
}

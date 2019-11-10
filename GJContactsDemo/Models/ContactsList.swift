//
//  ContactsList.swift
//  GJContactsDemo
//
//  Created by pvharsha on 8/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation

enum ContactServiceEvent:String {
    case ListFetch
    case ContactDetailsFetch
    case ContactCreate
    case ContactUpdate
    case ContactDelete
}

class ContactsList {
    
    var contacts: [Contact] = []
    var error: NSError? = nil
    
    var contactListObserver: (([Contact], ContactServiceEvent)-> Void)?
    var errorObserver: ((NSError, ContactServiceEvent)-> Void)?
    
    lazy var serviceManager:ServiceManagerProtocol = ServiceManager.sharedInstance
    
    required init(_ contactsObserver:@escaping ([Contact], ContactServiceEvent)-> Void, errorObserver:@escaping (NSError, ContactServiceEvent)-> Void) {
        
        self.contactListObserver = contactsObserver
        self.errorObserver = errorObserver
        self.fetch()
    }
    
    func fetch() {
        
        self.serviceManager.getContactsList(onSuccess: { (contacts) in
            
            self.contacts = contacts.sorted(by: { $0.fullName < $1.fullName })
            self.contactListObserver?(self.contacts, ContactServiceEvent.ListFetch)
        }, onFailure: { (error) in
            
            // here we can fetch the data from local cache if the app has offline access
            self.error = error
            self.errorObserver?(self.error!, ContactServiceEvent.ListFetch)
        })
    }
}

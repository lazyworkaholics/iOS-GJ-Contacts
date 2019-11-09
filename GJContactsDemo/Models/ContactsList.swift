//
//  ContactsList.swift
//  GJContactsDemo
//
//  Created by pvharsha on 8/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation

class ContactsList {
    
    var contacts:[Contact] = [] // add an observer on this contacts
    var error:NSError? = nil    // add an observer on this error
    
    init() {
        self.fetch()
    }
    
    func fetch() {
        ServiceManager.sharedInstance.getContactsList(onSuccess: { (contacts) in
            self.contacts = contacts
        }, onFailure: { (error) in
            // here we can fetch the data from cached data from local database
            self.error = error
        })
    }
    
    func createContact(contact:Contact, profilePic:UIImage?) {
        ServiceManager.sharedInstance.createNewContact(contact, profilePic: profilePic, onSuccess: { (contact) in
            self.contacts.append(contact)
        }, onFailure: { (error) in
            self.error = error
        })
    }
}

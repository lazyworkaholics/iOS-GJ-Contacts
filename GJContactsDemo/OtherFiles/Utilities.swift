//
//  Utilities.swift
//  GJContactsDemo
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class Utilities {

    // MARK: - internal functions
    func searchAndSort(contacts:[Contact], with searchString:String) -> [Int: ContactListSection] {
        let searchContacts = self.search(contacts: contacts, with: searchString)
        
        var sortedContactList: [Int: ContactListSection] = [:]
        
        let sortedContacts = searchContacts.sorted(by: { $0.fullName < $1.fullName })
        let sectionTitles = UILocalizedIndexedCollation.current().sectionTitles
        
        var index = 0
        for title in sectionTitles {
            let contacts1 = sortedContacts.filter({ $0.fullName.capitalized.hasPrefix(title)})
            if contacts1.count > 0 {
                sortedContactList[index] = ContactListSection.init(sectionTitle: title, contacts: contacts1)
                index += 1
            }
        }
        return sortedContactList
    }
    
    private func search(contacts:[Contact], with searchString:String) -> [Contact] {
        if searchString == "" {
            return contacts
        }
        var searchContacts:[Contact] = []
        
        for contact:Contact in contacts {
            if contact.fullName.lowercased().contains(searchString.lowercased()) {
                searchContacts.append(contact)
            }
        }
        return searchContacts
    }
}

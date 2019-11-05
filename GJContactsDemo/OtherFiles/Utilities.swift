//
//  Utilities.swift
//  GJContactsDemo
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class Utilities {

    // MARK: - searchAndSort functions
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
    
    // MARK: - email and phone number validations
    func isEmailAddressValid(_ emailString:String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: emailString, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, emailString.count)) != nil
        } catch {
            return false
        }
    }
    
    func isPhoneNumberValid(_ phoneNumber: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: phoneNumber)
        return result
    }
    
    func keyValuePairForEditContact(_ contact: Contact, initialValue:Contact) -> [String:String] {
        
        var keyValuePair:[String:String] = [:]
        
        if contact.firstName != initialValue.firstName {
            keyValuePair["first_name"] = contact.firstName
        }
        if contact.lastName != initialValue.lastName {
            keyValuePair["last_name"] = contact.lastName
        }
        if contact.profilePicUrl != initialValue.profilePicUrl {
            keyValuePair["profile_pic"] = contact.profilePicUrl
        }
        if contact.isFavorite != initialValue.isFavorite {
            keyValuePair["favorite"] = String(contact.isFavorite)
        }
        if contact.phoneNumber != initialValue.phoneNumber {
            keyValuePair["phone_number"] = contact.phoneNumber
        }
        if contact.email != initialValue.email {
            keyValuePair["email"] = contact.email
        }
        return keyValuePair
    }
}

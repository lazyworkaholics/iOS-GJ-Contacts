//
//  ContactsListViewModel.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
import UIKit

protocol ContactsListViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadTableView()
    
}

//MARK: -
struct ContactListSection {
    let sectionTitle: String
    let contacts: [Contact]
}

//MARK: - ContactsListViewModel
class ContactsListViewModel {
    
    private var contactsRawData:[Contact] = []
    private var contactsDataSource:[Int:ContactListSection] = [:]
    private var contactsSearchDataSource:[Int:ContactListSection] = [:]
    private var dataSourceError:NSError?
    
    var listProtocol:ContactsListViewModelProtocol?
    var serviceManager = ServiceManager.sharedInstance
    
    var isSearchEnabled:Bool = false
    var searchString:String = ""
    
    func viewControllerLoaded() {
        self.listProtocol?.showLoadingIndicator()
        serviceManager.getContactsList(
            onSuccess: {
                (contacts) in
                self.contactsRawData = contacts
                self.contactsDataSource = self.sortContacts(contacts: contacts)
                self.listProtocol?.reloadTableView()
                self.listProtocol?.hideLoadingIndicator()
        },
            onFailure: {
                (error) in
                self.dataSourceError = error
                self.listProtocol?.hideLoadingIndicator()
                self.listProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
    
    func updateSearchResults(with searchString: String) {
        isSearchEnabled = true
        let searchContacts:[Contact] = self.search(contacts: contactsRawData, with: searchString)
        contactsSearchDataSource = self.sortContacts(contacts: searchContacts)
        listProtocol?.reloadTableView()
    }
    
    func dismissSearch() {
        isSearchEnabled = false
        listProtocol?.reloadTableView()
    }
    
    // MARK:- tableView's data source handler functions
    func getSectionCount() -> Int {
        
        if isSearchEnabled {
            return contactsSearchDataSource.keys.count
        }
        return contactsDataSource.keys.count
    }
    
    func getRowCount(for section:Int) -> Int {
        
        if isSearchEnabled {
            return contactsSearchDataSource[section]?.contacts.count ?? 0
        }
        return contactsDataSource[section]?.contacts.count ?? 0
    }
    
    func getContact(for indexPath:IndexPath) -> Contact {
        
        var contacts:[Contact]?
        if isSearchEnabled {
            contacts = contactsSearchDataSource[indexPath.section]?.contacts
        } else {
            contacts = contactsDataSource[indexPath.section]?.contacts
        }
        
        return contacts![indexPath.row]
    }
    
    func getSectionTitles() -> [String] {
        
        var dataSource = contactsDataSource
        if isSearchEnabled {
            dataSource = contactsSearchDataSource
        }
        
        var titles:[String] = []
        var index = 0
        while dataSource[index] != nil {
            titles.append(dataSource[index]!.sectionTitle)
            index += 1
        }
        return titles
    }
    
    func getSectionHeaderTitle(section: Int) -> String {
        
        var titles = self.getSectionTitles()
        return titles[section]
    }
    
    // MARK: - internal functions
    private func sortContacts(contacts:[Contact]) -> [Int: ContactListSection] {
        
        var sortedContactList: [Int: ContactListSection] = [:]
        
        let sortedContacts = contacts.sorted(by: { $0.fullName < $1.fullName })
        let sectionTitles = UILocalizedIndexedCollation.current().sectionTitles
        
        var index = 0
        for title in sectionTitles {
            let contacts = sortedContacts.filter({ $0.fullName.capitalized.hasPrefix(title)})
            if contacts.count > 0 {
                sortedContactList[index] = ContactListSection.init(sectionTitle: title, contacts: contacts)
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
            if contact.fullName.contains(searchString) {
                searchContacts.append(contact)
            }
        }
        return searchContacts
    }
}

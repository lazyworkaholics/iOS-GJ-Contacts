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

struct ContactListSection {
    let sectionTitle: String
    let contacts: [Contact]
}

class ContactsListViewModel {
    
    private var contactsDataSource:[Int:ContactListSection] = [:]
    private var dataSourceError:NSError?
    
    var listProtocol:ContactsListViewModelProtocol?
    var serviceManager = ServiceManager.sharedInstance
    
    func viewControllerLoaded() {
        self.listProtocol?.showLoadingIndicator()
        serviceManager.getContactsList(
            onSuccess: {
                (contacts) in
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
    
    // MARK:- tableView's data source handler functions
    func getSectionCount() -> Int {
        
        return contactsDataSource.keys.count
    }
    
    func getRowCount(for section:Int) -> Int {
        
        return contactsDataSource[section]?.contacts.count ?? 0
    }
    
    func getContact(for indexPath:IndexPath) -> Contact {
        
        let contacts = contactsDataSource[indexPath.section]?.contacts
        return contacts![indexPath.row]
    }
    
    func getSectionTitles() -> [String] {
        
        var titles:[String] = []
        var index = 0
        while contactsDataSource[index] != nil {
            titles.append(contactsDataSource[index]!.sectionTitle)
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
}

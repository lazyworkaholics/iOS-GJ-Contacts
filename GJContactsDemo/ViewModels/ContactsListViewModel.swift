//
//  ContactsListViewModel.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ContactsListViewModel
class ContactsListViewModel {
    
    private var contactsRawData:[Contact] = []
    private var contactsDataSource:[Int:ContactListSection] = [:]
    private var dataSourceError:NSError?
    
    var listProtocol:ContactListViewModelProtocol?
    var serviceManager = ServiceManager.sharedInstance
    
    var isSearchEnabled:Bool = false
    var searchString:String = ""
    
    // MARK:- data source functions
    func loadData() {
        
        self.listProtocol?.showLoadingIndicator()
        serviceManager.getContactsList(
            onSuccess: {
                (contacts) in
                self.contactsRawData = contacts
                self.contactsDataSource = Utilities().searchAndSort(contacts: self.contactsRawData, with: self.searchString)
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
    
    func updateSearchResults(with searchString: String, isSearchEnabled: Bool) {
        
        self.isSearchEnabled = isSearchEnabled
        if isSearchEnabled {
            self.searchString = searchString
        } else {
            self.searchString = ""
        }
        self.contactsDataSource = Utilities().searchAndSort(contacts: self.contactsRawData, with: self.searchString)
        listProtocol?.reloadTableView()
    }
    
    // MARK:- routing functions
    func invokeDetailView(_ indexPath:IndexPath) {
        
        let contact = self.getContact(for: indexPath)
        let detailViewModel = ContactDetailViewModel.init(contact)
        let contactDetailVC = ContactDetailsViewController.initWithViewModel(detailViewModel)
        listProtocol?.routeToDetailView(contactDetailVC)
    }
    
    func invokeAddView() {
        
        let editViewModel = ContactEditViewModel.init(nil)
        let addViewController = ContactEditViewController.initWithViewModel(editViewModel)
        listProtocol?.routeToAddView(addViewController)
    }
    
    // MARK:- viewcontroller tableView handler functions
    func getSectionCount() -> Int {
        
        return contactsDataSource.keys.count
    }
    
    func getRowCount(for section:Int) -> Int {
        
        return contactsDataSource[section]?.contacts.count ?? 0
    }
    
    func getContact(for indexPath:IndexPath) -> Contact {
        
        var contacts = contactsDataSource[indexPath.section]?.contacts
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
}

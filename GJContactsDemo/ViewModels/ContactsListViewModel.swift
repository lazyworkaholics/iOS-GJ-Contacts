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
    
    var listProtocol:ContactListViewModelProtocol?

    var isSearchEnabled:Bool = false
    var searchString:String = ""
    
    var dataSource:ContactsList?
    private var _dataSourceError:NSError?
    private var _sortedDataSource:[Int:ContactListSection] = [:]
    
    var router:RouterProtocol = Router.sharedInstance
    
    init() {
        dataSource = ContactsList.init({ (contacts, event) in
            
            self.updateResults(with: "", isSearchEnabled: false)
            self.listProtocol?.hideLoadingIndicator()
        }, errorObserver: { (error, event) in
            
            self.listProtocol?.hideLoadingIndicator()
            self.listProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
    
    // MARK:- data source functions
    func fetch() {
        
        listProtocol?.showLoadingIndicator()
        dataSource?.fetch()
    }
    
    func updateResults(with searchString: String, isSearchEnabled: Bool) {
        
        self.isSearchEnabled = isSearchEnabled
        if isSearchEnabled {
            self.searchString = searchString
        } else {
            self.searchString = ""
        }
        _sortedDataSource = Utilities().searchAndSort(contacts: self.dataSource?.contacts ?? [], with: self.searchString)
        self.listProtocol?.reloadTableView()
    }
    
    // MARK:- routing functions
    func invokeDetailView(_ indexPath:IndexPath) {
        
        let contact = self.getContact(for: indexPath)
        router.navigateToDetailView(with: contact)
    }
    
    func invokeAddView() {
        
        router.launchCreateView()
    }
    
    // MARK:- viewcontroller tableView handler functions
    func getSectionCount() -> Int {
        
        return _sortedDataSource.keys.count
    }
    
    func getRowCount(for section:Int) -> Int {
        
        return _sortedDataSource[section]?.contacts.count ?? 0
    }
    
    func getContact(for indexPath:IndexPath) -> Contact {
        
        var contacts = _sortedDataSource[indexPath.section]?.contacts
        return contacts![indexPath.row]
    }
    
    func getSectionTitles() -> [String] {
        
        var titles:[String] = []
        var index = 0
        while _sortedDataSource[index] != nil {
            titles.append(_sortedDataSource[index]!.sectionTitle)
            index += 1
        }
        return titles
    }
    
    func getSectionHeaderTitle(section: Int) -> String {
        
        var titles = self.getSectionTitles()
        return titles[section]
    }
}

//
//  ContactDetailViewModel.swift
//  GJContactsDemo
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

//MARK: - ContactDetailViewModel
class ContactDetailViewModel {
    
    //MARK:- variables and initializers
    private var dataSource:Contact!
    
    var detailProtocol:ContactDetailProtocol?
    var serviceManager = ServiceManager.sharedInstance
    
    init(_ contact: Contact) {
        self.dataSource = contact
    }
    
    // MARK:- data source functions
    func loadData() {
        
    }
    
    // MARK:- routing functions
    func invokeEditView() {
        
        let editViewModel = ContactEditViewModel.init()
        let editViewController = ContactEditViewController.initWithViewModel(editViewModel)
        detailProtocol?.routeToEditView(editViewController)
    }
}

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
    private var dataSourceError:NSError?
    
    var detailProtocol:ContactDetailProtocol?
    var serviceManager = ServiceManager.sharedInstance
    
    init(_ contact: Contact) {
        self.dataSource = contact
    }
    
    // MARK:- data source functions
    func loadData() {
        detailProtocol?.loadData(dataSource)
        detailProtocol?.showLoadingIndicator()
        serviceManager.getContactDetails(dataSource.id,
                                         onSuccess: {
                                            (contact) in
                                            
                                            self.dataSource.update(contact: contact)
                                            self.detailProtocol?.loadData(self.dataSource)
                                            self.detailProtocol?.hideLoadingIndicator()
        },
                                         onFailure: {
                                            (error) in
                                            
                                            self.dataSourceError = error
                                            self.detailProtocol?.hideLoadingIndicator()
                                            self.detailProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
    
    // MARK:- routing functions
    func invokeEditView() {
        
        let editViewModel = ContactEditViewModel.init()
        let editViewController = ContactEditViewController.initWithViewModel(editViewModel)
        detailProtocol?.routeToEditView(editViewController)
    }
    
    // MARK:- viewcontroller handler functions
}

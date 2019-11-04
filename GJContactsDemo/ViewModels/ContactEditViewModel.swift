//
//  ContactEditViewModel.swift
//  GJContactsDemo
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ContactEditViewModel {

    //MARK:- variables and initializers
    private var dataSource:Contact?
    private var dataSourceError:NSError?
    
    var editProtocol:ContactEditProtocol?
    var serviceManager = ServiceManager.sharedInstance
    
    init(_ contact: Contact?) {
        self.dataSource = contact
    }
    
    func loadData() {
        editProtocol?.loadData(self.dataSource!)
    }
    
    func updateContact(_ contact:Contact) {
        
        if contact == dataSource {
            editProtocol?.dismissView()
        }
        else {
            if dataSource == nil {
                editProtocol?.showLoadingIndicator()
                serviceManager.createNewContact(contact,
                                                onSuccess: { (contact) in

                                                    self.editProtocol?.hideLoadingIndicator()
                                                    self.editProtocol?.dismissView()
                },
                                                onFailure: {(error) in
                    
                                                    self.editProtocol?.hideLoadingIndicator()
                                                    self.editProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
                })
            }
            else {
                editProtocol?.showLoadingIndicator()
                serviceManager.editContact(contact,
                                           onSuccess: { (contact) in
                                            
                                            self.editProtocol?.hideLoadingIndicator()
                                            self.editProtocol?.dismissView()
                },
                                           onFailure: {(error) in
                                            
                                            self.editProtocol?.hideLoadingIndicator()
                                            self.editProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
                })
            }
        }
    }
}

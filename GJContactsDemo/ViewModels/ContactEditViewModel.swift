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
    private var originalContact:Contact!
    private var dataSourceError:NSError?
    
    var editProtocol:ContactEditProtocol?
    var serviceManager = ServiceManager.sharedInstance
    
    init(_ contact: Contact?) {
        
        if contact != nil {
            self.originalContact = contact
        } else {
            self.originalContact = Contact(id: 0, firstName: "", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "", email: "", createDate: "", lastUpdateDate: "")
        }
    }
    
    // MARK:- viewcontroller tableView handler functions
    func loadData() {
        self.editProtocol?.loadData(originalContact)
    }
    
    func updateContact(_ contact:Contact) {
        
        if contact == originalContact {
            editProtocol?.dismissView()
        }
        else {
            if self.originalContact == Contact(id: 0, firstName: "", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "", email: "", createDate: "", lastUpdateDate: "") {
                self.createContact(contact)
            }
            else {
                self.editContact(contact)
            }
        }
    }
    
    // MARK:- internal private functions
    
    private func createContact(_ contact: Contact) {
        editProtocol?.showLoadingIndicator()
        serviceManager.createNewContact(contact,
                                        onSuccess: { (contact1) in
                                            
                                            self.editProtocol?.hideLoadingIndicator()
                                            self.editProtocol?.dismissView()
        },
                                        onFailure: {(error) in
                                            
                                            self.editProtocol?.hideLoadingIndicator()
                                            self.editProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
    
    private func editContact(_ contact: Contact) {
        editProtocol?.showLoadingIndicator()
        serviceManager.editContact(contact,
                                   onSuccess: { (contact1) in
                                    
                                    self.editProtocol?.hideLoadingIndicator()
                                    self.editProtocol?.dismissView()
        },
                                   onFailure: {(error) in
                                    
                                    self.editProtocol?.hideLoadingIndicator()
                                    self.editProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
}

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
    func textMessage() {
        
        if Utilities().isPhoneNumberValid(self.dataSource.phoneNumber ?? "") {
            guard let smsUrl = URL.init(string: (StringConstants.SMS_URL_PRETEXT + self.dataSource.phoneNumber!)) else {
                detailProtocol?.showStaticAlert(StringConstants.CANNOT_MESSAGE, message: StringConstants.INVALID_PHONE_NUMBER)
                return
            }
            UIApplication.shared.open(smsUrl, options: [:], completionHandler: nil)
        } else {
            detailProtocol?.showStaticAlert(StringConstants.CANNOT_MESSAGE, message: StringConstants.INVALID_PHONE_NUMBER)
        }
    }
    
    func makePhoneCall() {
        
        if Utilities().isPhoneNumberValid(self.dataSource.phoneNumber ?? "") {
            guard let phoneURL = URL.init(string: (StringConstants.PHONE_URL_PRETEXT + self.dataSource.phoneNumber!)) else {
                detailProtocol?.showStaticAlert(StringConstants.CANNOT_PHONE, message: StringConstants.INVALID_PHONE_NUMBER)
                return
            }
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            detailProtocol?.showStaticAlert(StringConstants.CANNOT_PHONE, message: StringConstants.INVALID_PHONE_NUMBER)
        }
    }
    
    func invokeEmail() {
        
        if Utilities().isEmailAddressValid(self.dataSource.email ?? "") {
            guard let emailURL = URL.init(string: (StringConstants.MAIL_URL_PRETEXT + self.dataSource.email!)) else {
                detailProtocol?.showStaticAlert(StringConstants.CANNOT_EMAIL, message: StringConstants.INVALID_EMAIL_ADDRESS)
                return
            }
            UIApplication.shared.open(emailURL, options: [:], completionHandler: nil)
        } else {
            detailProtocol?.showStaticAlert(StringConstants.CANNOT_EMAIL, message: StringConstants.INVALID_EMAIL_ADDRESS)
        }
    }
    
    func markFavourite(_ isFavourite:Bool) {
        
        detailProtocol?.showLoadingIndicator()
        dataSource.isFavorite = isFavourite
        serviceManager.editContact(dataSource,
                                   onSuccess: { (contact) in
                                    
                                    self.dataSource.update(contact: contact)
                                    self.detailProtocol?.loadData(self.dataSource)
                                    self.detailProtocol?.hideLoadingIndicator()
        },
                                   onFailure:  { (error) in
                                    
                                    self.dataSource.isFavorite = !isFavourite
                                    self.detailProtocol?.loadData(self.dataSource)
                                    self.dataSourceError = error
                                    self.detailProtocol?.hideLoadingIndicator()
                                    self.detailProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
}

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
    var dataSource:Contact!
    private var dataSourceError:NSError?
    
    var detailProtocol:ContactDetailProtocol?
    
    var router:RouterProtocol = Router.sharedInstance
    
    init(_ contact: Contact) {
        
        dataSource = contact
    }
    
    // MARK:- data source functions
    func fetch() {
        
        dataSource.contactObserver =  ({
            (contact, error, serviceEvent) -> Void in
            self.contactObserver(contact, error, serviceEvent)
        })
        detailProtocol?.loadUI(dataSource)
        detailProtocol?.showLoadingIndicator()
        dataSource.getDetails()
    }
    
    func contactObserver(_ contact:Contact?, _ error:NSError?, _ serviceEvent:ContactServiceEvent) {
        
        if error != nil {
            
            dataSourceError = error
            detailProtocol?.showStaticAlert(StringConstants.ERROR, message: error!.localizedDescription)
        } else {
            
            switch serviceEvent {
            case ContactServiceEvent.ContactDelete:
                
                router.popDetailView()
                break
            case ContactServiceEvent.ContactDetailsFetch:
                
                dataSource = contact!
                detailProtocol?.loadUI(dataSource)
                break
            default:
                break
            }
        }
        detailProtocol?.hideLoadingIndicator()
    }
    
    // MARK:- routing functions
    func invokeEditView() {
        
        router.launchEditView(with: self.dataSource)
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
        dataSource.isContactModifiedLocally = true
        dataSource.contactObserver =  ({
            (contact, error, serviceEvent) -> Void in
            self.contactObserver(contact, error, serviceEvent)
        })
        dataSource.push(nil)
    }
    
    func delete() {
        
        dataSource.contactObserver =  ({
            (contact, error, serviceEvent) -> Void in
            self.contactObserver(contact, error, serviceEvent)
        })
        detailProtocol?.showLoadingIndicator()
        dataSource.delete()
    }
    
    func dismissDetailView() {
        
        router.popDetailView()
    }
}

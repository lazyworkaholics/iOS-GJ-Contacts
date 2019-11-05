//
//  ContactEditViewModel.swift
//  GJContactsDemo
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

struct EditContactTableViewCellData {
    var fieldName: String!
    var fieldValue: String!
    var keyBoardType: UIKeyboardType!
    var profilePic: UIImage?
}

class ContactEditViewModel {

    //MARK:- variables and initializers
    private var dataSource:Contact!
    private var initialValue:Contact!
    private var dataSourceError:NSError?
    
    var editProtocol:ContactEditProtocol?
    var serviceManager = ServiceManager.sharedInstance
    
    private var isAddContact:Bool!
    private var isContactUpdated:Bool!
    
    private var profilePic:UIImage?
    
    init(_ contact: Contact?) {
        
        if contact != nil {
            isAddContact = false
            dataSource = contact
        } else {
            isAddContact = true
            dataSource = Contact(id: 0, firstName: "", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: "", phoneNumber: "", email: "", createDate: "", lastUpdateDate: "")
        }
        initialValue = self.dataSource
    }
    
    // MARK:- viewcontroller tableView handler functions
    func populateTableCell(_ index:Int) -> EditContactTableViewCellData? {
        switch index {
        case 0:
            return EditContactTableViewCellData.init(fieldName: StringConstants.PROFILE_PIC, fieldValue: dataSource.profilePicUrl, keyBoardType: .default, profilePic: profilePic)
        case 1:
            return EditContactTableViewCellData.init(fieldName: StringConstants.FIRST_NAME, fieldValue: dataSource.firstName, keyBoardType: .default, profilePic: nil)
        case 2:
            return EditContactTableViewCellData.init(fieldName: StringConstants.LAST_NAME, fieldValue: dataSource.lastName, keyBoardType: .default, profilePic: nil)
        case 3:
            return EditContactTableViewCellData.init(fieldName: StringConstants.MOBILE, fieldValue: dataSource.phoneNumber, keyBoardType: .phonePad, profilePic: nil)
        case 4:
            return EditContactTableViewCellData.init(fieldName: StringConstants.EMAIL, fieldValue: dataSource.email, keyBoardType: .emailAddress, profilePic: nil)
        default:
            break
        }
        return nil
    }
    
    func dataUpdated(fieldName:String, fieldValue:String) {
        
        if fieldName == StringConstants.FIRST_NAME {
            dataSource.firstName = fieldValue
        } else if fieldName == StringConstants.LAST_NAME {
            dataSource.lastName = fieldValue
        } else if fieldName == StringConstants.MOBILE {
            dataSource.phoneNumber = fieldValue
        } else if fieldName == StringConstants.EMAIL {
            dataSource.email = fieldValue
        }
    }
    
    func profilePicUpdated(image:UIImage) {
        profilePic = image
    }
    
    func pushContact() {
        
        if dataSource == initialValue {
            editProtocol?.dismissView()
        }
        else {
            if isAddContact {
                self.createContact(dataSource)
            }
            else {
                self.editContact(dataSource)
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
        serviceManager.editContact(contact, initialValue: initialValue,
                                   onSuccess: { (contact1) in
                                    
                                    self.editProtocol?.hideLoadingIndicator()
                                    self.editProtocol?.dismissView()
        },
                                   onFailure: {(error) in
                                    
                                    self.editProtocol?.hideLoadingIndicator()
                                    self.editProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
    
    private func cleanContact(_ contact: Contact) -> Contact {
        
        return Contact(id: contact.id, firstName: contact.firstName, lastName: contact.lastName, profilePicUrl: contact.profilePicUrl, isFavorite: contact.isFavorite, detailsUrl: nil, phoneNumber: contact.phoneNumber, email: contact.email, createDate: nil, lastUpdateDate: nil)
    }
}

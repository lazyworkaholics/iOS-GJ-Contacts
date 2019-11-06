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
            if self.inputValidations(contact: dataSource) {
                if isAddContact {
                    self.createContact(dataSource)
                }
                else {
                    self.editContact(dataSource)
                }
            }
        }
    }
    
    // MARK:- internal private functions
    
    private func createContact(_ contact: Contact) {
        editProtocol?.showLoadingIndicator()
        serviceManager.createNewContact(contact, profilePic: profilePic,
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
        serviceManager.editContact(contact, initialValue: initialValue, profilePic: profilePic,
                                   onSuccess: { (contact1) in
                                    
                                    self.editProtocol?.hideLoadingIndicator()
                                    self.editProtocol?.dismissView()
        },
                                   onFailure: {(error) in
                                    
                                    self.editProtocol?.hideLoadingIndicator()
                                    self.editProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
    
    private func inputValidations(contact:Contact) -> Bool {
        
        var isValid = true
        
        if contact.firstName.count < 2 || contact.lastName.count < 2{
            editProtocol?.showStaticAlert(StringConstants.NAME_INVALID_TITLE, message: StringConstants.NAME_INVALID_MESSAGE)
            isValid = false
            return isValid
        }
        
        let phoneNum_length = contact.phoneNumber?.count ?? 0
        if  phoneNum_length != 0 && phoneNum_length < 10 {
            editProtocol?.showStaticAlert(StringConstants.INVALID_PHONE_NUMBER, message: StringConstants.PHONE_INVALID_MESSAGE)
            isValid = false
            return isValid
        }
        
        if contact.email != nil && contact.email != "" {
            if !(Utilities().isEmailAddressValid(contact.email!)) {
                editProtocol?.showStaticAlert(StringConstants.INVALID_EMAIL_ADDRESS, message: StringConstants.INVALID_EMAIL_ADDRESS_MESSAGE)
                isValid = false
                return isValid
            }
        }
        return isValid
    }
}

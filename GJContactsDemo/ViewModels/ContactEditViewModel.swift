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
    var fieldValue: String? = nil
    var keyBoardType: UIKeyboardType!
    var profilePic: UIImage?
}

class ContactEditViewModel {

    //MARK:- variables and initializers
    var editProtocol:ViewModelProtocol?
    
    var dataSource:Contact!
    var dataSourceError:NSError?
    var isAddContact:Bool!
    var profilePic:UIImage?
    
    var router:RouterProtocol = Router.sharedInstance
    
    init(_ contact: Contact?) {
        
        if contact != nil {
            
            isAddContact = false
            dataSource = contact
        } else {
            isAddContact = true
            dataSource = Contact.init(nil, firstName: "", lastName: "", profilePicUrl: "", isFavorite: false, detailsUrl: "")
        }
    }
    
    // MARK:- viewcontroller tableView handler functions
    func populateTableCell(_ index:Int) -> EditContactTableViewCellData? {
        switch index {
        case 0:
            return EditContactTableViewCellData.init(fieldName: StringConstants.PROFILE_PIC, fieldValue: dataSource?.profilePicUrl, keyBoardType: .default, profilePic: profilePic)
        case 1:
            return EditContactTableViewCellData.init(fieldName: StringConstants.FIRST_NAME, fieldValue: dataSource?.firstName, keyBoardType: .default, profilePic: nil)
        case 2:
            return EditContactTableViewCellData.init(fieldName: StringConstants.LAST_NAME, fieldValue: dataSource?.lastName, keyBoardType: .default, profilePic: nil)
        case 3:
            return EditContactTableViewCellData.init(fieldName: StringConstants.MOBILE, fieldValue: dataSource?.phoneNumber, keyBoardType: .phonePad, profilePic: nil)
        case 4:
            return EditContactTableViewCellData.init(fieldName: StringConstants.EMAIL, fieldValue: dataSource?.email, keyBoardType: .emailAddress, profilePic: nil)
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
        dataSource.isContactModifiedLocally = true
    }
    
    func profilePicUpdated(image:UIImage) {
        profilePic = image
        dataSource?.isContactModifiedLocally = true
    }
    
    func contactObserver(_ contact:Contact?, _ error:NSError?, _ serviceEvent:ContactServiceEvent) {
        
        if error != nil {
            
            self.editProtocol?.showStaticAlert(StringConstants.ERROR, message: error!.localizedDescription)
        } else {
            
            if serviceEvent == .ContactCreate {
                
                self.editProtocol?.showDoubleActionAlert?(StringConstants.CONTACT_CREATE, message: StringConstants.SUCCESSFUL,
                                                          firstTitle: StringConstants.OK, secondTitle: nil,
                                                          onfirstClick: {
                                                            
                                                            self.router.dismissEditView(true)
                },
                                                          onSecondClick: nil)
            } else if serviceEvent == .ContactUpdate {
                
                self.editProtocol?.showDoubleActionAlert?(StringConstants.CONTACT_UPDATE, message: StringConstants.SUCCESSFUL,
                                                          firstTitle: StringConstants.OK, secondTitle: nil,
                                                          onfirstClick: {
                                                            
                                                            self.router.dismissEditView(true)
                },
                                                          onSecondClick: nil)
            }
        }
        self.editProtocol?.hideLoadingIndicator()
    }
    
    func pushContact() {
        
        if self._inputValidations(contact: dataSource!) {
            
            dataSource.contactObserver = ({
                (contact, error, serviceEvent) -> Void in
                self.contactObserver(contact, error, serviceEvent)
            })
            self.editProtocol?.showLoadingIndicator()
            
            if isAddContact {
                dataSource?.create(profilePic)
            }
            else {
                dataSource?.push(profilePic)
            }
        }
    }
    
    func dismissView() {
        
        router.dismissEditView(false)
    }
    
    // MARK:- internal private functions
    private func _inputValidations(contact:Contact) -> Bool {
        
        var isValid = true
        
        let firstNameCount = contact.firstName?.count ?? 0
        let lastNameCount = contact.lastName?.count ?? 0
        if firstNameCount < 2 || lastNameCount < 2{
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

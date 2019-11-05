//
//  ServiceManagerMock.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
@testable import GJContactsDemo

class ServiceManagerMock: ServiceManager {
    
    //stubs for getContactsList
    var contacts: [Contact]?
    var error: NSError?
    var isSuccess: Bool?
    
    var isSuccessBlock_invoked = false
    var isFailureBlock_invoke = false
    
    //stubs for getContactDetails
    var getContactDetail_contact: Contact?
    var getContactDetail_error: NSError?
    var is_getContactDetail_Success: Bool?
    
    var is_getContactDetail_SuccessBlock_invoked = false
    var is_getContactDetail_FailureBlock_invoked = false
    
    //stubs for editContact
    var editContactService_contact: Contact?
    var editContact_error: NSError?
    var is_editContact_Success: Bool?
    
    var is_editContact_SuccessBlock_invoked = false
    var is_editContact_FailureBlock_invoked = false
    
    //stubs for createContact
    var createContactService_contact: Contact?
    var createContact_error: NSError?
    var is_createContact_Success: Bool?
    
    var is_createContact_SuccessBlock_invoked = false
    var is_createContact_FailureBlock_invoked = false
    
    //stubs for createContact
    var deleteContact_error: NSError?
    var is_deleteContact_Success: Bool?
    
    var is_deleteContact_SuccessBlock_invoked = false
    var is_deleteContact_FailureBlock_invoked = false
    
    override init() {
        super.init()
    }
    
    override func getContactsList(onSuccess successBlock: @escaping ([Contact]) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        
        if isSuccess!
        {
            isSuccessBlock_invoked = true
            isFailureBlock_invoke = false
            successBlock(contacts!)
        }
        else
        {
            isSuccessBlock_invoked = false
            isFailureBlock_invoke = true
            failureBlock(error!)
        }
    }
    
    override func getContactDetails(_ contactId: Int, onSuccess successBlock: @escaping (Contact) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        
        if is_getContactDetail_Success!
        {
            is_getContactDetail_SuccessBlock_invoked = true
            is_getContactDetail_FailureBlock_invoked = false
            successBlock(getContactDetail_contact!)
        }
        else
        {
            is_getContactDetail_SuccessBlock_invoked = false
            is_getContactDetail_FailureBlock_invoked = true
            failureBlock(getContactDetail_error!)
        }
    }
    
    override func editContact(_ contact: Contact, initialValue: Contact, onSuccess successBlock: @escaping (Contact) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        if is_editContact_Success!
        {
            is_editContact_SuccessBlock_invoked = true
            is_editContact_FailureBlock_invoked = false
            successBlock(editContactService_contact!)
        }
        else
        {
            is_editContact_SuccessBlock_invoked = false
            is_editContact_FailureBlock_invoked = true
            failureBlock(editContact_error!)
        }
    }
    
    override func createNewContact(_ contact: Contact, onSuccess successBlock: @escaping (Contact) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        if is_createContact_Success!
        {
            is_createContact_SuccessBlock_invoked = true
            is_createContact_FailureBlock_invoked = false
            successBlock(createContactService_contact!)
        }
        else
        {
            is_createContact_SuccessBlock_invoked = false
            is_createContact_FailureBlock_invoked = true
            failureBlock(createContact_error!)
        }
    }
    
    override func deleteContact(_ contact: Contact, onSuccess successBlock: @escaping (Bool) -> Void, onFailure failureBlock: @escaping (NSError) -> Void) {
        if is_deleteContact_Success!
        {
            is_deleteContact_SuccessBlock_invoked = true
            is_deleteContact_FailureBlock_invoked = false
            successBlock(true)
        }
        else
        {
            is_deleteContact_SuccessBlock_invoked = false
            is_deleteContact_FailureBlock_invoked = true
            failureBlock(deleteContact_error!)
        }
    }
}

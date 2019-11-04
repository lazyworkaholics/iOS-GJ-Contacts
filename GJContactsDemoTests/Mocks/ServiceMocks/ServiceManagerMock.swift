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
}

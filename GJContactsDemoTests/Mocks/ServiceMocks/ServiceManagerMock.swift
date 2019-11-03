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
    
    var contacts: [Contact]?
    var error: NSError?
    var isSuccess: Bool?
    
    var isSuccessBlock_invoked = false
    var isFailureBlock_invoke = false
    
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
}

//
//  MockContact.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit
@testable import GJContactsDemo

class MockContact: Contact {
    
    var isSuccess = false
    var isContactPushSuccess:Bool = false

    override func push(_ profilePic:UIImage?) {
        
        if self.isContactModifiedLocally ?? false {
            
            isContactPushSuccess = isSuccess
        } else {
            
            isContactPushSuccess = false
        }
    }
}

//
//  MockContactEditViewModel.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit
@testable import GJContactsDemo

class MockContactEditViewModel: ContactEditViewModel {

    var dismissViewInvoked = false
    var pushContactInvoked = false
    
    override func dismissView() {
        dismissViewInvoked = true
    }
    
    override func pushContact() {
        pushContactInvoked = true
    }
}

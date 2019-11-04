//
//  ContactEditViewModelProtocol_StubClass.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit
@testable import GJContactsDemo

class ContactEditProtocol_StubClass: ContactEditProtocol {
    var isShowLoadingIndicator_invoked = false
    var isHideLoadingIndicator_invoked = false
    
    
    var showStaticAlert_invoked = false
    var showStaticAlert_Title = ""
    var showStaticAlert_Message = ""
    
    var is_loadData_invoked = false
    var is_dismissView_invoked = false

    func showStaticAlert(_ title: String, message: String) {
        showStaticAlert_invoked = true
        showStaticAlert_Title = title
        showStaticAlert_Message = message
    }
    
    func showLoadingIndicator() {
        isShowLoadingIndicator_invoked = true
    }
    
    func hideLoadingIndicator() {
        isHideLoadingIndicator_invoked = true
    }
    
    func loadData(_ contact:Contact?) {
        is_loadData_invoked = true
    }
    
    func dismissView() {
        is_dismissView_invoked = true
    }
}

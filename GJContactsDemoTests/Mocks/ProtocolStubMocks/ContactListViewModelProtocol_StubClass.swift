//
//  ContactListViewModelProtocol_StubClass.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
@testable import GJContactsDemo

class ContactListViewModelProtocol_StubClass: ContactListViewModelProtocol {
    
    var isShowLoadingIndicator_involed = false
    var isHideLoadingIndicator_involed = false
    var reloadTableView_involed = false

    var showStaticAlert_involed = false
    var showStaticAlert_Title = ""
    var showStaticAlert_Message = ""
    
    func showStaticAlert(_ title: String, message: String) {
        showStaticAlert_involed = true
        showStaticAlert_Title = title
        showStaticAlert_Message = message
    }
    
    func showLoadingIndicator() {
        isShowLoadingIndicator_involed = true
    }
    
    func hideLoadingIndicator() {
        isHideLoadingIndicator_involed = true
    }
    
    func reloadTableView() {
        reloadTableView_involed = true
    }
}

//
//  RouterMock.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 11/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit
@testable import GJContactsDemo

class RouterMock: RouterProtocol {
    
    var isAppLaunched_called:Bool = false
    var isnavigateToDetailView_called:Bool = false
    var ispopDetailView_called:Bool = false
    var islaunchEditView_called:Bool = false
    var islaunchCreateView_called:Bool = false
    var isDismisEditView_called:Bool = false
    
    
    func appLaunch(_ window: UIWindow) {
        isAppLaunched_called = true
    }
    
    func navigateToDetailView(with contact: Contact) {
        isnavigateToDetailView_called = true
    }
    
    func popDetailView() {
        ispopDetailView_called = true
    }
    
    func launchEditView(with contact: Contact) {
        islaunchEditView_called = true
    }
    
    func launchCreateView() {
        islaunchCreateView_called = true
    }
    
    func dismissEditView(_ isContactUpdated: Bool) {
        isDismisEditView_called = true
    }
}

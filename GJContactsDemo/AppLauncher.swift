//
//  AppLauncher.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
import UIKit

struct AppLauncher {
    
    public func initialViewController() -> UIViewController {
        
        let viewModel = ContactsListViewModel.init()
        let contactsListViewController = ContactsListViewController.initWithViewModel(viewModel)
        
        UINavigationBar.appearance().tintColor = ColorConstants.NAVBAR_TINT_COLOR
        let navigationController = UINavigationController(rootViewController: contactsListViewController)
        return navigationController
    }
}

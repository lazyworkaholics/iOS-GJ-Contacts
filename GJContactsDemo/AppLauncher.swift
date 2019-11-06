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
        
        UINavigationBar.appearance().tintColor = UIColor.init(named: StringConstants.Colors.APP_COLOR)
        let navigationController = UINavigationController(rootViewController: contactsListViewController)
        return navigationController
    }
}

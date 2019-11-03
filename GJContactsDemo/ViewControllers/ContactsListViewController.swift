//
//  ViewController.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController, ViewControllerProtocol {
    
    var viewModel: ViewModelProtocol!
    
    class func initWithViewModel(_ viewModel:ViewModelProtocol) -> ViewControllerProtocol {
        
        let storyBoardRef = UIStoryboard.init(name: StringConstants.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: StringConstants.ViewControllers.CONTACTSLISTVC) as! ContactsListViewController
        
        viewController.viewModel = viewModel
        return viewController
    }
}


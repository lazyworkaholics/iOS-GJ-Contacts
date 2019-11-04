//
//  ContactsDetailViewController.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    //MARK:- iboutlets and variables
    var viewModel: ContactDetailViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel:ContactDetailViewModel) -> ContactDetailsViewController {
        
        let storyBoardRef = UIStoryboard.init(name: StringConstants.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: StringConstants.ViewControllers.CONTACT_DETAIL_VC) as! ContactDetailsViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.detailProtocol = viewController
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem.init(title: StringConstants.EDIT, style: .plain, target: self, action: #selector(ContactDetailsViewController.edit_buttonAction))
        rightBarButton.accessibilityIdentifier = StringConstants.EDIT
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    //MARK:- Custom Button Actions
    @objc func edit_buttonAction() {
        
        viewModel.invokeEditView()
    }
}

extension ContactDetailsViewController: ContactDetailProtocol {
    func showLoadingIndicator() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
        })
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            MBProgressHUD.hide(for: self.view, animated: true)
        })
    }
    
    
    func showStaticAlert(_ title: String, message: String) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: StringConstants.OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func routeToEditView(_ editViewController: ContactEditViewController) {
        DispatchQueue.main.async(execute: {() -> Void in
            self.present(UINavigationController.init(rootViewController: editViewController), animated: true, completion: nil)
        })
    }
}

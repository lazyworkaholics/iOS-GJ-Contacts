//
//  ContactEditViewController.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ContactEditViewController: UIViewController {

    //MARK:- iboutlets and variables
    var viewModel: ContactEditViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel:ContactEditViewModel) -> ContactEditViewController {
        
        let storyBoardRef = UIStoryboard.init(name: StringConstants.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: StringConstants.ViewControllers.CONTACT_EDIT_VC) as! ContactEditViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.editProtocol = viewController
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem.init(title: StringConstants.CANCEL, style: .plain, target: self, action: #selector(ContactEditViewController.cancel_buttonAction))
        leftBarButton.accessibilityIdentifier = StringConstants.CANCEL
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem.init(title: StringConstants.DONE, style: .plain, target: self, action: #selector(ContactEditViewController.done_buttonAction))
        rightBarButton.accessibilityIdentifier = StringConstants.DONE
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        viewModel.loadData()
    }
    
    //MARK:- Custom Button Actions
    @objc func cancel_buttonAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func done_buttonAction() {
        
        showStaticAlert("In Progress", message: "To be implmented")
    }
}

extension ContactEditViewController:ContactEditProtocol {
    func dismissView() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    func loadData(_ contact: Contact) {
        
    }
    
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
}

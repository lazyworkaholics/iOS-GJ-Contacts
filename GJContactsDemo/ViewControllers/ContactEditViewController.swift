//
//  ContactEditViewController.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit
import QuartzCore

class ContactEditViewController: UIViewController {

    //MARK:- iboutlets and variables
    var viewModel: ContactEditViewModel!
    private var textField_InFocus:UITextField?
    private var imagePicker:UIImagePickerController?
    
    @IBOutlet var profilePic_imageView:UIImageView!
    
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
        
        profilePic_imageView.layer.cornerRadius = profilePic_imageView.bounds.size.width/5;
        profilePic_imageView.layer.borderColor = UIColor.white.cgColor
        profilePic_imageView.layer.borderWidth = 1
        profilePic_imageView.layer.masksToBounds = true;
        
        viewModel.loadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField_InFocus?.resignFirstResponder()
    }
    
    //MARK:- Custom Button Actions
    @objc func cancel_buttonAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func done_buttonAction() {
        
//        viewModel.updateContact()
    }
    
    @IBAction func camera_buttonAction() {
        imagePicker =  UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .photoLibrary
        present(imagePicker!, animated: true, completion: nil)
    }
}

extension ContactEditViewController: ContactEditProtocol {
    func loadData(_ contact:Contact) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.profilePic_imageView.image(urlString: contact.profilePicUrl, withPlaceHolder: UIImage.init(named: StringConstants.Assets.PLACEHOLDER_PHOTO), doOverwrite: false)
        })
    }
    func dismissView() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.dismiss(animated: true, completion: nil)
        })
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

extension ContactEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField_InFocus = textField
    }
}

extension ContactEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return picker.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.profilePic_imageView.image = image
            picker.dismiss(animated: true, completion: nil)
        })
    }
}

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
    @IBOutlet var profilePic_imgView:UIImageView!
    @IBOutlet var name_lbl:UILabel!
    @IBOutlet var favourite_button:UIButton!
    @IBOutlet var email_lbl:UILabel!
    @IBOutlet var phoneNumber_lbl:UILabel!
    @IBOutlet var profilePic_BgView:UIView!
    
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
        navigationItem.rightBarButtonItem = rightBarButton
        
        let leftBarButton = UIBarButtonItem.init(title: StringConstants.CONTACT, style: .plain, target: self, action: #selector(ContactDetailsViewController.back_buttonAction))
        leftBarButton.accessibilityIdentifier = StringConstants.CONTACT
        navigationItem.leftBarButtonItem = leftBarButton
        
        profilePic_imgView.layer.cornerRadius = profilePic_imgView.bounds.size.width/2;
        profilePic_imgView.layer.borderColor = UIColor.white.cgColor
        profilePic_imgView.layer.borderWidth = 1
        profilePic_imgView.layer.masksToBounds = true;
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.init(red: 50, green: 227, blue: 194, alpha: 0.28).cgColor]
        gradientLayer.frame = profilePic_BgView.bounds
        profilePic_BgView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    //MARK:- Custom Button Actions
    @objc func edit_buttonAction() {
        
        viewModel.invokeEditView()
    }
    
    @objc func back_buttonAction() {
        
        viewModel.dismissDetailView()
    }
    
    @IBAction func message_buttonAction(sender:UIButton) {
        viewModel.textMessage()
    }
    
    @IBAction func phone_buttonAction(sender:UIButton) {
        viewModel.makePhoneCall()
    }
    
    @IBAction func email_buttonAction(sender:UIButton) {
        viewModel.invokeEmail()
    }
    
    @IBAction func favourite_buttonAction(sender:UIButton) {
        
        if sender.tag == StringConstants.FAVOURITE_BUTTON_NOT_SELECTED_TAG {
            
            self.favourite_button.setImage(UIImage.init(named: StringConstants.Assets.FAVOURITE_BUTTON_SELECTED), for: .normal)
            sender.tag = StringConstants.FAVOURITE_BUTTON_SELECTED_TAG
            
            viewModel.markFavourite(true)
        } else {
            
            self.favourite_button.setImage(UIImage.init(named: StringConstants.Assets.FAVOURITE_BUTTON), for: .normal)
            sender.tag = StringConstants.FAVOURITE_BUTTON_NOT_SELECTED_TAG
            
            viewModel.markFavourite(false)
        }
    }
    
    @IBAction func delete_buttonAction(sender:UIButton) {
        let alert = UIAlertController.init(title: "Delete this Contact?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: StringConstants.OK,
                                           style: .default,
                                           handler:{ (alertAction) in
                                            self.viewModel.delete()
        }))
        alert.addAction(UIAlertAction.init(title: StringConstants.CANCEL, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

//MARK:- ContactDetailProtocol functions
extension ContactDetailsViewController: ContactDetailProtocol {
    
    func loadUI(_ contact:Contact) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.profilePic_imgView.image(urlString: contact.profilePicUrl, withPlaceHolder: UIImage.init(named: StringConstants.Assets.PLACEHOLDER_PHOTO), doOverwrite: false)
            self.name_lbl.text = contact.fullName
            if contact.isFavorite {
                self.favourite_button.setImage(UIImage.init(named: StringConstants.Assets.FAVOURITE_BUTTON_SELECTED), for: .normal)
                self.favourite_button.tag = StringConstants.FAVOURITE_BUTTON_SELECTED_TAG
            } else {
                self.favourite_button.setImage(UIImage.init(named: StringConstants.Assets.FAVOURITE_BUTTON), for: .normal)
                self.favourite_button.tag = StringConstants.FAVOURITE_BUTTON_NOT_SELECTED_TAG
            }
            self.email_lbl.text = contact.email
            self.phoneNumber_lbl.text = contact.phoneNumber
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

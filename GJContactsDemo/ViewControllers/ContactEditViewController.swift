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
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var tableViewBottomLayoutConstraint : NSLayoutConstraint!
    private var textfield_in_focus:UITextField?
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func showKeyboard(notification:NSNotification) {
        DispatchQueue.main.async {
            let rect:CGRect? = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect
            self.tableViewBottomLayoutConstraint.constant = rect?.size.height ?? 100
            self.tableView.layoutIfNeeded()
        }
    }
    
    @objc func hideKeyboard(notification:NSNotification) {
        DispatchQueue.main.async {
            self.tableViewBottomLayoutConstraint.constant = 0
            self.tableView.layoutIfNeeded()
        }
    }
    
    //MARK:- Custom Button Actions
    @objc func cancel_buttonAction() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func done_buttonAction() {
        viewModel.pushContact()
        guard let tag = textfield_in_focus?.tag else {
            return
        }
        
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: tag, section: 0)) as? EditContactCell
        viewModel.dataUpdated(fieldName: cell?.field_name_lbl.text ?? "", fieldValue: cell?.field_value_txtField.text ?? "")
        cell?.field_value_txtField.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.textfield_in_focus?.resignFirstResponder()
    }
}

extension ContactEditViewController: ContactEditProtocol {
    
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

extension ContactEditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }
        return 61
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data:EditContactTableViewCellData? = viewModel.populateTableCell(indexPath.row)
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier:  StringConstants.Views.EDIT_TABLE_VIEW_IMAGE_CELL, for: indexPath) as! EditContactImageViewCell
            cell.viewControllerRef = self
            if data?.profilePic != nil {
                cell.profilePic_imageView.image = data?.profilePic
            } else {
                cell.profilePic_imageView.image(urlString: data?.fieldValue ?? "", withPlaceHolder: UIImage.init(named: StringConstants.Assets.PLACEHOLDER_PHOTO), doOverwrite: false)
            }
            cell.profilePic_imageView.layer.cornerRadius = cell.profilePic_imageView.bounds.size.width/5;
            cell.profilePic_imageView.layer.borderColor = UIColor.white.cgColor
            cell.profilePic_imageView.layer.borderWidth = 1
            cell.profilePic_imageView.layer.masksToBounds = true;
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.Views.EDIT_TABLE_VIEW_CELL, for: indexPath) as! EditContactCell
            cell.field_value_txtField.tag = indexPath.row
            cell.field_value_txtField.delegate = self
            cell.field_name_lbl.text = data?.fieldName
            cell.field_value_txtField.text = data?.fieldValue
            cell.field_value_txtField.keyboardType = data?.keyBoardType ?? UIKeyboardType.namePhonePad
            return cell
        }
    }
}

extension ContactEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row != 0 {
            let cell = tableView.cellForRow(at: indexPath) as! EditContactCell
            cell.field_value_txtField.becomeFirstResponder()
        }
    }
}

extension ContactEditViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textfield_in_focus = textField
        let tag = textField.tag
        self.tableView.scrollToRow(at: IndexPath.init(row: tag, section: 0), at: .none, animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        if tag < 4 {
            self.tableView.scrollToRow(at: IndexPath.init(row: tag+1, section: 0), at: .none, animated: false)
            let cell = tableView.cellForRow(at: IndexPath.init(row: tag+1, section: 0)) as? EditContactCell
            if cell != nil {
                cell?.field_value_txtField.becomeFirstResponder()
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        let cell = tableView.cellForRow(at: IndexPath.init(row: tag, section: 0)) as? EditContactCell
        viewModel.dataUpdated(fieldName: cell?.field_name_lbl.text ?? "", fieldValue: cell?.field_value_txtField.text ?? "")
        self.textfield_in_focus = nil
    }
}

extension ContactEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return picker.dismiss(animated: true, completion: nil)
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.viewModel.profilePicUpdated(image: image)
            picker.dismiss(animated: true, completion: nil)
        })
    }
}

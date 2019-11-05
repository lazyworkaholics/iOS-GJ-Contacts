//
//  EditContactImageCell.swift
//  GJContactsDemo
//
//  Created by pvharsha on 5/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class EditContactImageViewCell: UITableViewCell {
    
    @IBOutlet var profilePic_imageView:UIImageView!
    var viewControllerRef:ContactEditViewController?
    var imagePicker:UIImagePickerController?

    @IBAction func camera_buttonAction() {
        imagePicker =  UIImagePickerController()
        imagePicker?.delegate = viewControllerRef
        imagePicker?.sourceType = .photoLibrary
        viewControllerRef?.present(imagePicker!, animated: true, completion: nil)
    }
}

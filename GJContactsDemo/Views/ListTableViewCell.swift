//
//  ListTableViewCell.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet var name_lbl:UILabel!
    @IBOutlet var profilePic_imgView:UIImageView!
    @IBOutlet var isFavourite_btn:UIButton!
    
    func configUI(contact: Contact) {
        
        name_lbl.text = contact.fullName
        profilePic_imgView.image(urlString: contact.profilePicUrl, withPlaceHolder: UIImage.init(named: StringConstants.Assets.PLACEHOLDER_PHOTO), doOverwrite: false)
        if contact.isFavorite {
            isFavourite_btn.setImage(UIImage.init(named: StringConstants.Assets.FAVOURITE_BUTTON_SELECTED), for: .normal)
        } else {
            isFavourite_btn.setImage(UIImage.init(named: StringConstants.Assets.FAVOURITE_BUTTON), for: .normal)
        }
    }
}

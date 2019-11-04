//
//  EditContactCell.swift
//  GJContactsDemo
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class EditContactCell: UITableViewCell {

    @IBOutlet var field_name_lbl:UILabel!
    @IBOutlet var field_value_txtField:UITextField!
    
    func configUI(fieldName: String, fieldValue: String) {
        
        field_name_lbl.text = fieldName
        field_value_txtField.text = fieldValue
    }
}

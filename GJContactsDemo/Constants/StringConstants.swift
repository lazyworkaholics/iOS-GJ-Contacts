//
//  StringConstants.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//
import UIKit

struct StringConstants {
    
    static let MAIN     = "Main"
    static let OK       = "OK"
    static let ERROR    = "Error"
    static let CONTACT  = "Contact"
    static let GROUPS   = "Groups"
    static let ADD      = "Add"
    static let SEARCH   = "Search"
    static let CANCEL   = "Cancel"
    static let DONE     = "Done"
    static let EDIT     = "Edit"
    
    static let SMS_URL_PRETEXT      = "sms:"
    static let PHONE_URL_PRETEXT    = "tel:"
    static let MAIL_URL_PRETEXT     = "mailto:"
    
    static let CANNOT_MESSAGE   = "Cannot open messanger"
    static let CANNOT_PHONE     = "Cannot make a phone call"
    static let CANNOT_EMAIL     = "Cannot send a mail"
    
    static let INVALID_PHONE_NUMBER     = "phone number not valid"
    static let INVALID_EMAIL_ADDRESS    = "email address not valid"
    
    
    static let FAVOURITE_BUTTON_NOT_SELECTED_TAG    = 4000
    static let FAVOURITE_BUTTON_SELECTED_TAG        = 4001
    
    static let LISTVIEW_CELL  = "ListViewCell"
    
    struct ViewControllers {
        
        static let CONTACTS_LIST_VC     = "ContactsListViewController"
        static let CONTACT_DETAIL_VC    = "ContactDetailsViewController"
        static let CONTACT_EDIT_VC      = "ContactEditViewController"
    }
    
    struct Views {
        static let LIST_TABLE_VIEW_CELL = "ListTableViewCell"
    }
    
    struct Assets {
        static let PLACEHOLDER_PHOTO = "placeholder_photo"
        static let HOME_FAVOURITE = "home_favourite"
        static let FAVOURITE_BUTTON = "favourite_button"
        static let FAVOURITE_BUTTON_SELECTED = "favourite_button_selected"
    }
}

struct ColorConstants {
    static let NAVBAR_TINT_COLOR = #colorLiteral(red: 0.3140000105, green: 0.8899999857, blue: 0.7609999776, alpha: 1)
}

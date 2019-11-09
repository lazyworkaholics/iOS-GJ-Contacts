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
    static let MOBILE   = "mobile"
    static let EMAIL    = "email"
    static let FIRST_NAME   = "First Name"
    static let LAST_NAME    = "Last Name"
    static let PROFILE_PIC  = "Profile Pic"
    
    static let SMS_URL_PRETEXT      = "sms:"
    static let PHONE_URL_PRETEXT    = "tel:"
    static let MAIL_URL_PRETEXT     = "mailto:"
    
    static let CANNOT_MESSAGE   = "Cannot open messanger"
    static let CANNOT_PHONE     = "Cannot make a phone call"
    static let CANNOT_EMAIL     = "Cannot send a mail"
    
    static let INVALID_PHONE_NUMBER     = "phone number not valid"
    static let INVALID_EMAIL_ADDRESS    = "email not valid"
    static let INVALID_EMAIL_ADDRESS_MESSAGE = "enter a valid email"
    static let DELTE_CUSTOM_ERROR       = "Contact deletion is not successful due to unknown error"
    
    static let NAME_INVALID_TITLE       = "Invalid Name"
    static let NAME_INVALID_MESSAGE     = "First name and Last name should be more than 2 characters each"
    static let PHONE_INVALID_MESSAGE    = "phone number should be more than 10 digits"
    
    static let GROUPS_FUNCTIONALITY_TITLE = "Groups functionality not implemented"
    static let GROUPS_FUNCTIONALITY_MESSAGE = "Requirements are not specified in the given document"
    
    static let FAVOURITE_BUTTON_NOT_SELECTED_TAG    = 4000
    static let FAVOURITE_BUTTON_SELECTED_TAG        = 4001
    
    static let LISTVIEW_CELL  = "ListViewCell"
    
    struct ViewControllers {
        
        static let CONTACTS_LIST_VC     = "ContactsListViewController"
        static let CONTACT_DETAIL_VC    = "ContactDetailsViewController"
        static let CONTACT_EDIT_VC      = "ContactEditViewController"
    }
    
    struct Views {
        static let LIST_TABLE_VIEW_CELL         = "ListTableViewCell"
        static let EDIT_TABLE_VIEW_CELL         = "EditContactCell"
        static let EDIT_TABLE_VIEW_IMAGE_CELL   = "EditContactImageViewCell"
    }
    
    struct Assets {
        static let PLACEHOLDER_PHOTO = "placeholder_photo"
        static let HOME_FAVOURITE = "home_favourite"
        static let FAVOURITE_BUTTON = "favourite_button"
        static let FAVOURITE_BUTTON_SELECTED = "favourite_button_selected"
    }
    
    struct Colors {
        static let APP_COLOR                = "appColor"
        static let LIST_VIEW_HEADER_COLOR   = "listViewHeaderColor"
    }
    
    struct Fonts {
        static let APP_FONT_NAME         = "Helvetica"
        static let APP_FONT_SIZE:CGFloat = 14
    }
}

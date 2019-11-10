//
//  AppConstants.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

struct Network_Constants {
    static let BASE_URL = "http://gojek-contacts-app.herokuapp.com"
    
    static let CONTACTS_LIST_PATH = "contacts.json"
    
    static let EDIT_CONTACT_PRE_RELATIVE_PATH = "contacts/"
    static let EDIT_CONTACT_POST_RELATIVE_PATH = ".json"
    
    static let HTTP_HEADER_CONTENT_TYPE_KEY = "Content-Type"
    static let HTTP_HEADER_CONTENT_TYPE_VALUE_APP_JSON = "application/json"
}

struct Network_Error_Constants {
    static let ERROR_DOMAIN = "com.networkErrorDomain"
    static let URLSESSION_ERROR = 0
    static let NOT_REACHABLE = 1
    static let PARSING_ERROR = 2
    static let EDIT_CONTACT_NOCHANGES_ERROR = 3
    static let LOCAL_ERROR_DOMAIN = "com.gojek.localErrorDomain"
    static let EDIT_CONTACT_NOCHANGES_LOCAL_DESCRIPTION = "There are no changes in this contact to push."
}

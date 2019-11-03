//
//  Contact.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

public struct Contact: Codable, Equatable {
    var id: Int!
    var firstName: String!
    var lastName: String!
    var profilePicUrl: String!
    
    var isFavorite: Bool = false
    var detailsUrl: String!
    
    var phoneNumber: String?
    var email: String?
    
    var createDate: String?
    var lastUpdateDate: String?
    
    var fullName: String {
        if firstName != "" && lastName != "" {
            return firstName + " " + lastName
        }
        return firstName + lastName
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePicUrl = "profile_pic"
        case isFavorite = "favorite"
        case detailsUrl = "epaper"
        case phoneNumber = "phone_number"
        case email = "email"
        case createDate = "created_at"
        case lastUpdateDate = "updated_at"
    }
    
    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        if (lhs.id == rhs.id) &&
            (lhs.firstName == rhs.firstName) &&
            (lhs.lastName == rhs.lastName) &&
            (lhs.profilePicUrl == rhs.profilePicUrl) &&
            (lhs.isFavorite == rhs.isFavorite) &&
            (lhs.detailsUrl == rhs.detailsUrl) &&
            (lhs.phoneNumber == rhs.phoneNumber) &&
            (lhs.email == rhs.email) &&
            (lhs.createDate == rhs.createDate) &&
            (lhs.lastUpdateDate == rhs.lastUpdateDate)
        {
            return true
        }
        return false
    }
    
    public static func != (lhs: Contact, rhs: Contact) -> Bool {
        if  (lhs.id != rhs.id) ||
            (lhs.firstName != rhs.firstName) ||
            (lhs.lastName != rhs.lastName) ||
            (lhs.profilePicUrl != rhs.profilePicUrl) ||
            (lhs.isFavorite != rhs.isFavorite) ||
            (lhs.detailsUrl != rhs.detailsUrl) ||
            (lhs.phoneNumber != rhs.phoneNumber) ||
            (lhs.email != rhs.email) ||
            (lhs.createDate != rhs.createDate) ||
            (lhs.lastUpdateDate != rhs.lastUpdateDate)
        {
            return true
        }
        return false
    }
    
    mutating func update(contact:Contact) {
        self.id = contact.id
        self.firstName = contact.firstName
        self.lastName = contact.lastName
        self.profilePicUrl = contact.profilePicUrl
        self.isFavorite = contact.isFavorite
        self.detailsUrl = contact.detailsUrl
        self.phoneNumber = contact.phoneNumber
        self.email = contact.email
        self.createDate = contact.createDate
        self.lastUpdateDate = contact.lastUpdateDate
    }
}

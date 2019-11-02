//
//  Contact.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

public struct Contact: Codable {
    var id: Int!
    var firstName: String!
    var lastName: String!
    var profilePicUrl: String!
    
    var isFavorite: Bool = false
    var detailsUrl: String!
    
    var phoneNumber: String?
    var email: String?
    
    var createDate:String?
    var lastUpdateDate:String?
    
    var fullName:String {
        if firstName != "" && lastName != "" {
            return firstName + " " + lastName
        } else {
            return firstName + lastName
        }
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
}

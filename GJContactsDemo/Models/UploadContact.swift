//
//  UploadContact.swift
//  GJContactsDemo
//
//  Created by pvharsha on 6/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

public struct UploadContact: Codable, Equatable {
    
    var firstName: String?
    var lastName: String?
    var isFavorite: Bool?
    var phoneNumber: String?
    var email: String?
    var profilePic: Data?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case isFavorite = "favorite"
        case phoneNumber = "phone_number"
        case email = "email"
        case profilePic = "profile_pic"
    }
}

//
//  Contact.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

//MARK: -
class Contact: Codable, Equatable {
    
    //MARK:- Variables
    var id: Int?
    var firstName: String!
    var lastName: String!
    var profilePicUrl: String!
    var isFavorite: Bool!
    var detailsUrl: String!
    
    var phoneNumber: String?
    var email: String?
    var createDate: String?
    var lastUpdateDate: String?
    
    var contactObserver: ((Contact?, NSError?, ContactServiceEvent)-> Void)?
    
    var isContactModifiedLocally: Bool?
    lazy var serviceManager:ServiceManagerProtocol = ServiceManager.sharedInstance
    
    var fullName: String {
        
        if firstName != "" && lastName != "" {
            
            return firstName + " " + lastName
        }
        return firstName + lastName
    }
    
    private init() {
        
    }
    
    convenience init(_ id: Int?, firstName:String, lastName:String, profilePicUrl:String, isFavorite:Bool, detailsUrl:String) {
        
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicUrl = profilePicUrl
        self.detailsUrl = detailsUrl
        self.isFavorite =  isFavorite
    }
    
    
    
    //MARK:- Codable and Equatable confirmations
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePicUrl = "profile_pic"
        case isFavorite = "favorite"
        case detailsUrl = "url"
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
    
    //MARK: - webservice functions
    func getDetails() {
        
        self.serviceManager.getContactDetails(self.id!, onSuccess: { (contact) in
            
            self.contactObserver?(contact, nil, ContactServiceEvent.ContactDetailsFetch)
        }, onFailure: { (error) in
            
            self.contactObserver?(nil, error, ContactServiceEvent.ContactDetailsFetch)
        })
    }
    
    func push(_ profilePic:UIImage?) {
        
        if self.isContactModifiedLocally ?? false {
            
            let uploadContact = self._getUploadContact(profilePic)
            self.serviceManager.editContact(uploadContact, onSuccess: { (contact) in
                
                self.contactObserver?(contact, nil, ContactServiceEvent.ContactUpdate)
            }, onFailure: { (error) in
                
                self.contactObserver?(nil, error, ContactServiceEvent.ContactUpdate)
            })
        } else {
            
            let error = NSError.init(domain: Network_Error_Constants.LOCAL_ERROR_DOMAIN, code: Network_Error_Constants.EDIT_CONTACT_NOCHANGES_ERROR, userInfo: [NSLocalizedDescriptionKey: Network_Error_Constants.EDIT_CONTACT_NOCHANGES_LOCAL_DESCRIPTION])
            self.contactObserver?(nil, error, ContactServiceEvent.ContactUpdate)
        }
    }
    
    func create(_ profilePic:UIImage?) {
        
        let uploadContact = self._getUploadContact(profilePic)
        self.serviceManager.createNewContact(uploadContact, onSuccess: { (contact) in
            
            self.contactObserver?(contact, nil, ContactServiceEvent.ContactCreate)
        }, onFailure: { (error) in
            
            self.contactObserver?(nil, error, ContactServiceEvent.ContactCreate)
        })
    }
    
    func delete() {
        
        self.serviceManager.deleteContact(self, onSuccess: { (isSuccess) in
            
            self.contactObserver?(nil, nil, ContactServiceEvent.ContactDelete)
        }, onFailure: { (error) in
            
            self.contactObserver?(nil, error, ContactServiceEvent.ContactDelete)
        })
    }
    
    //MARK: - internal functions
    private func _getUploadContact(_ profilePic: UIImage?) -> UploadContact {
        
        var stringId:String? = nil
        if self.id != nil {
            stringId = String(self.id!)
        }
        return UploadContact(id: stringId, firstName: self.firstName, lastName: self.lastName, isFavorite: self.isFavorite, phoneNumber: self.phoneNumber, email: self.email, profilePic: profilePic?.pngData())
    }
}

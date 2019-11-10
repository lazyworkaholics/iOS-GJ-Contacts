//
//  ServiceManagerProtocol.swift
//  GJContactsDemo
//
//  Created by pvharsha on 10/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation

protocol ServiceManagerProtocol {
    
    static var sharedInstance:ServiceManagerProtocol {get set}
    
    func getContactsList(onSuccess successBlock:@escaping ([Contact])->Void,
                         onFailure failureBlock:@escaping (NSError)->Void)
    
    func getContactDetails(_ contactId:Int,
                           onSuccess successBlock:@escaping (Contact)->Void,
                           onFailure failureBlock:@escaping (NSError)->Void)
    
    func editContact(_ uploadContact:UploadContact,
                     onSuccess successBlock:@escaping (Contact)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
    
    func createNewContact(_ uploadContact: UploadContact,
                          onSuccess successBlock:@escaping (Contact)->Void,
                          onFailure failureBlock:@escaping (NSError)->Void)
    
    func deleteContact(_ contact:Contact,
                       onSuccess successBlock:@escaping (Bool)->Void,
                       onFailure failureBlock:@escaping (NSError)->Void)
}

//
//  ServiceManager.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//
import Foundation

class ServiceManager
{
    static let sharedInstance = ServiceManager()
    var networkManager : NetworkManager
    
    init() {
        networkManager = NetworkManager.sharedInstance
    }
    
    //MARK: - Core functions to handle webservices
    public func getContactsList(onSuccess successBlock:@escaping ([Contact])->Void,
                                onFailure failureBlock:@escaping (NSError)->Void) {
        
        self.networkRequest(urlPath: Network_Constants.CONTACTS_LIST_PATH, params: nil, method: .GET, headers: nil, body: nil,
                            onSuccess: { (contacts) in
                                
                                successBlock(contacts)
        },
                            onFailure: { (error) in

                                failureBlock(error)
        })
    }
    
    public func getContactDetails(_ contactId:Int,
                                  onSuccess successBlock:@escaping (Contact)->Void,
                                  onFailure failureBlock:@escaping (NSError)->Void) {
        
        let relativePath = Network_Constants.EDIT_CONTACT_PRE_RELATIVE_PATH + String(contactId) + Network_Constants.EDIT_CONTACT_POST_RELATIVE_PATH

        self.networkRequest(urlPath: relativePath, params: nil, method: .GET, headers: nil, body: nil,
                            onSuccess: { (updatedContact) in
                                
                                successBlock(updatedContact)
        },
                            onFailure: { (error) in
                                
                                failureBlock(error)
        })
    }

    public func createNewContact(_ contact:Contact,
                                 onSuccess successBlock:@escaping (Contact)->Void,
                                 onFailure failureBlock:@escaping (NSError)->Void) {
        
        let encoder = JSONEncoder.init()
        do {
            let data = try encoder.encode(contact)
            let headers = [Network_Constants.HTTP_HEADER_CONTENT_TYPE_KEY : Network_Constants.HTTP_HEADER_CONTENT_TYPE_VALUE_APP_JSON]
            self.networkRequest(urlPath: Network_Constants.CONTACTS_LIST_PATH, params: nil, method: .POST, headers: headers, body: data,
                                onSuccess: { (updatedContact) in
                                    
                                    successBlock(updatedContact)
            },
                                onFailure: { (error) in
                                    
                                    failureBlock(error)
            })
        }
        catch {
            failureBlock(error as NSError)
        }
    }

    public func editContact(_ contact:Contact,
                                 onSuccess successBlock:@escaping (Contact)->Void,
                                 onFailure failureBlock:@escaping (NSError)->Void) {
        
        let encoder = JSONEncoder.init()
        do {
            let data = try encoder.encode(contact)
            
            let relativePath = Network_Constants.EDIT_CONTACT_PRE_RELATIVE_PATH + String(contact.id) + Network_Constants.EDIT_CONTACT_POST_RELATIVE_PATH
            
            let headers = [Network_Constants.HTTP_HEADER_CONTENT_TYPE_KEY : Network_Constants.HTTP_HEADER_CONTENT_TYPE_VALUE_APP_JSON]
            
            self.networkRequest(urlPath: relativePath, params: nil, method: .PUT, headers: headers, body: data,
                                onSuccess: { (updatedContact) in
                
                                    successBlock(updatedContact)
            },
                                onFailure: { (error) in
                
                                    failureBlock(error)
            })
        }
        catch {
            failureBlock(error as NSError)
        }
    }

    public func deleteContact(_ contact:Contact,
                            onSuccess successBlock:@escaping (Bool)->Void,
                            onFailure failureBlock:@escaping (NSError)->Void) {
        
        let relativePath = Network_Constants.EDIT_CONTACT_PRE_RELATIVE_PATH + String(contact.id) + Network_Constants.EDIT_CONTACT_POST_RELATIVE_PATH
        networkManager.httpRequest(relativePath, params: nil, method: .DELETE, headers: nil, body: nil,
                                   onSuccess: { (data) in
                                    
                                    successBlock(true)
        },
                                   onFailure: { (error) in
                                    
                                    failureBlock(error)
        })
    }
    
    //MARK: - Internal functions
    private func networkRequest<T:Codable>(urlPath:String,
                                           params: [String: String]?,
                                           method: HTTPRequestType,
                                           headers: [String: String]?,
                                           body: Data?,
                                           onSuccess successBlock:@escaping (T)->Void,
                                           onFailure failureBlock:@escaping (NSError)->Void) {
        networkManager.httpRequest(urlPath,
                                   params: params,
                                   method: method,
                                   headers: headers,
                                   body: body,
                                   onSuccess: { (data) in
                                    let decoder = JSONDecoder.init()
                                    do {
                                        let transformedData =  try decoder.decode(T.self, from: data)
                                        successBlock(transformedData)
                                    } catch {
                                        failureBlock(error as NSError)
                                    }
        },
                                   onFailure: { (error) in
                                    
                                    failureBlock(error)
        })
    }
}

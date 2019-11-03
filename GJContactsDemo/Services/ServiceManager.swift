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
                                onFailure failureBlock:@escaping (NSError)->Void)
    {
        self.networkRequest(urlPath: "contacts.json", params: nil, method: .GET, headers: nil, body: nil,
                            onSuccess: { (contacts) in
                                
                                successBlock(contacts)
        },
                            onFailure: { (error) in

                                failureBlock(error)
        })
    }
    
    public func getContactDetails(_ contactId:Int,
                                  onSuccess successBlock:@escaping (Contact)->Void,
                                  onFailure failureBlock:@escaping (NSError)->Void)
    {
        let relativePath = "contacts/" + String(contactId) + ".json"
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
                                 onFailure failureBlock:@escaping (NSError)->Void)
    {
        let encoder = JSONEncoder.init()
        do {
            let data = try encoder.encode(contact)
            self.networkRequest(urlPath: "contacts.json", params: nil, method: .POST, headers: ["Content-Type":"application/json"], body: data,
                                onSuccess: { (updatedContact) in
                                    
                                    successBlock(updatedContact)
            },
                                onFailure: { (error) in
                                    
                                    failureBlock(error)
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }

    public func editContact(_ contact:Contact,
                                 onSuccess successBlock:@escaping (Contact)->Void,
                                 onFailure failureBlock:@escaping (NSError)->Void)
    {
        let encoder = JSONEncoder.init()
        do {
            let data = try encoder.encode(contact)
            let relativePath = "contacts/" + String(contact.id) + ".json"
            self.networkRequest(urlPath: relativePath, params: nil, method: .PUT, headers: ["Content-Type":"application/json"], body: data,
                                onSuccess: { (updatedContact) in
                
                                    successBlock(updatedContact)
            },
                                onFailure: { (error) in
                
                                    failureBlock(error)
            })
        }
        catch {
            print(error.localizedDescription)
        }
    }

    public func deleteContact(_ contact:Contact,
                            onSuccess successBlock:@escaping (Bool)->Void,
                            onFailure failureBlock:@escaping (NSError)->Void)
    {
        let relativePath = "contacts/" + String(contact.id) + ".json"
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

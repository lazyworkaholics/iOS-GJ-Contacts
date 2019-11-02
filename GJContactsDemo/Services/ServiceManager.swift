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
    
    private init() {
        
    }
    
    public func getContactsList(onSuccess successBlock:@escaping ([Contact])->Void,
                                onFailure failureBlock:@escaping (NSError)->Void)
    {
        
    }
    
    public func getContactDetails(_ contact:[Contact],
                                  onSuccess successBlock:@escaping (Contact)->Void,
                                  onFailure failureBlock:@escaping (NSError)->Void)
    {
        
    }
    
    public func createNewContact(_ contact:[Contact],
                                 onSuccess successBlock:@escaping (Contact)->Void,
                                 onFailure failureBlock:@escaping (NSError)->Void)
    {
        
    }
    
    public func editContact(_ contact:[Contact],
                                 onSuccess successBlock:@escaping (Contact)->Void,
                                 onFailure failureBlock:@escaping (NSError)->Void)
    {
        
    }
    
    public func deleteContact(_ contact:[Contact],
                            onSuccess successBlock:@escaping (Bool)->Void,
                            onFailure failureBlock:@escaping (NSError)->Void)
    {
        
    }
}

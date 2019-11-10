//
//  NetworkManagerProtocol.swift
//  GJContactsDemo
//
//  Created by pvharsha on 10/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
    
    static var sharedInstance:NetworkManagerProtocol {get set}
    
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String: String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
}

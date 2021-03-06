//
//  NetworkManagerMock.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit
@testable import GJContactsDemo

class NetworkManagerMock: NetworkManagerProtocol {

    var data: Data?
    var error: NSError?
    var isSuccess: Bool?
    
    static var sharedInstance:NetworkManagerProtocol = NetworkManagerMock()
    
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String:String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
    {
        
        if isSuccess!
        {
            successBlock(data!)
        }
        else
        {
            failureBlock(error!)
        }
    }
}

//
//  ReachabilityMock.swift
//  GJContactsDemoTests
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
import Reachability

class ReachabilityMock: Reachability
{
    var reachableViaWifi = false
    var reachableViaWWAN = false
    
    override func isReachableViaWiFi() -> Bool {
        return reachableViaWifi
    }
    
    override func isReachableViaWWAN() -> Bool {
        return reachableViaWWAN
    }

}

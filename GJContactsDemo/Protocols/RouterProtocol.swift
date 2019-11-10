//
//  RouterProtocol.swift
//  GJContactsDemo
//
//  Created by pvharsha on 10/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation

protocol RouterProtocol {
    
    func appLaunch(_ window:UIWindow)
    
    func navigateToDetailView(with contact:Contact)
    
    func popDetailView()
    
    func launchEditView(with contact:Contact)
    
    func launchCreateView()
    
    func dismissEditView(_ isContactUpdated:Bool)
}

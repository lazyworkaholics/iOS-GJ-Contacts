//
//  ViewControllerProtocol.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation

protocol ViewControllerProtocol {
    
    var viewModel: ViewModelProtocol! { get set }
    
    static func initWithViewModel(_ viewModel:ViewModelProtocol) -> ViewControllerProtocol
}

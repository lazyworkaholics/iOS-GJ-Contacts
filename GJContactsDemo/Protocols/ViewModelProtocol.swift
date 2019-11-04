//
//  ViewModelProtocol.swift
//  GJContactsDemo
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

protocol ViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String)
    
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func reloadTableView()
    
}

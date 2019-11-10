//
//  ViewModelProtocol.swift
//  GJContactsDemo
//
//  Created by pvharsha on 4/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

@objc protocol ViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    @objc optional func showDoubleActionAlert(_ title: String, message: String, firstTitle:String, secondTitle:String, onfirstClick:(() -> Void), onSecondClick:(() -> Void))
}

protocol ContactListViewModelProtocol: ViewModelProtocol {
    
    func reloadTableView()
}

protocol ContactDetailProtocol: ViewModelProtocol {
    
    func loadUI(_ contact:Contact)
}

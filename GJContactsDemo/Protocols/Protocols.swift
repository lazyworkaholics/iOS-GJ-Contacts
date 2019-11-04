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
}

protocol ContactListViewModelProtocol: ViewModelProtocol {
    
    func reloadTableView()
    func routeToDetailView(_ detailViewController: ContactDetailsViewController)
    func routeToAddView(_ addViewController: ContactEditViewController)
}

protocol ContactDetailProtocol: ViewModelProtocol {
    
    func loadData(_ contact:Contact)
    func dismissView()
    func routeToEditView(_ editViewController: ContactEditViewController)
    
}

protocol ContactEditProtocol: ViewModelProtocol {
    
    func dismissView()
    func loadData(_ contact:Contact)
}

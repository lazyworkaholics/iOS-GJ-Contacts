//
//  AppLauncher.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import Foundation
import UIKit

enum AppRouteState:String {
    
    case listView
    case detailView
    case editView
    case createView
}

class Router: RouterProtocol {
    
    static var sharedInstance:Router = Router()
    
    var rootNavigationController:UINavigationController?
    var editNavigationController:UINavigationController?
    
    var listViewModel:ContactsListViewModel?
    var detailsViewModel:ContactDetailViewModel?
    var editViewModel:ContactEditViewModel?
    
    var currentRouteState:AppRouteState?
    
    func appLaunch(_ window:UIWindow) {

        self.listViewModel = ContactsListViewModel.init()
        let contactsListViewController = ContactsListViewController.initWithViewModel(self.listViewModel!)
        
        UINavigationBar.appearance().tintColor = UIColor.init(named: StringConstants.Colors.APP_COLOR)
        self.rootNavigationController = UINavigationController(rootViewController: contactsListViewController)
       
        window.tintColor = UIColor.init(named: StringConstants.Colors.APP_COLOR)
        window.rootViewController = self.rootNavigationController!
        window.makeKeyAndVisible()
        
        self.listViewModel!.fetch()
        self.currentRouteState = AppRouteState.listView
    }
    
    func navigateToDetailView(with contact:Contact) {
        
        if self.currentRouteState == AppRouteState.listView {
            
            self.detailsViewModel = ContactDetailViewModel.init(contact)
            let contactDetailVC = ContactDetailsViewController.initWithViewModel(self.detailsViewModel!)
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.rootNavigationController?.pushViewController(contactDetailVC, animated: true)
                self.detailsViewModel!.fetch()
                self.currentRouteState = AppRouteState.detailView
            })
        }
    }
    
    func popDetailView() {
        
        if self.currentRouteState == AppRouteState.detailView {
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.rootNavigationController?.popViewController(animated: true)
                self.listViewModel!.fetch()
                self.currentRouteState = AppRouteState.listView
            })
        }
    }
    
    func launchEditView(with contact:Contact) {
        
        if self.currentRouteState == AppRouteState.detailView {
            
            self.editViewModel = ContactEditViewModel.init(contact)
            let editViewController = ContactEditViewController.initWithViewModel(self.editViewModel!)
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.editNavigationController = UINavigationController.init(rootViewController: editViewController)
                self.rootNavigationController?.present(self.editNavigationController!, animated: true, completion: nil)
                self.currentRouteState = AppRouteState.editView
            })
        }
    }
    
    func launchCreateView() {
        
        if self.currentRouteState == AppRouteState.listView {
            
            self.editViewModel = ContactEditViewModel.init(nil)
            let editViewController = ContactEditViewController.initWithViewModel(self.editViewModel!)
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.editNavigationController = UINavigationController.init(rootViewController: editViewController)
                self.rootNavigationController?.present(self.editNavigationController!, animated: true, completion: nil)
                self.currentRouteState = AppRouteState.createView
            })
        }
    }
    
    func dismissEditView(_ isContactUpdated:Bool) {
        
        if self.currentRouteState == AppRouteState.editView {
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.editNavigationController?.topViewController?.dismiss(animated: true, completion: nil)
                self.currentRouteState = AppRouteState.detailView
                
                if isContactUpdated {
                    self.detailsViewModel?.fetch()
                }
            })
        }
        else if self.currentRouteState == AppRouteState.createView {
            
            DispatchQueue.main.async(execute: {() -> Void in
                self.editNavigationController?.topViewController?.dismiss(animated: true, completion: nil)
                self.currentRouteState = AppRouteState.listView
                
                self.listViewModel?.fetch()
            })
        }
    }
}

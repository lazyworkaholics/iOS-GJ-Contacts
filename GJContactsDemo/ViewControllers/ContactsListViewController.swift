//
//  ViewController.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController {
    
    @IBOutlet var tableView:UITableView!
    
    var viewModel: ContactsListViewModel!
    
    class func initWithViewModel(_ viewModel:ContactsListViewModel) -> ContactsListViewController {
        
        let storyBoardRef = UIStoryboard.init(name: StringConstants.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: StringConstants.ViewControllers.CONTACTSLISTVC) as! ContactsListViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.listProtocol = viewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoadingIndicator()
    }
}

extension ContactsListViewController: ContactsListViewModelProtocol {
    func showLoadingIndicator() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
        })
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            MBProgressHUD.hide(for: self.view, animated: true)
        })
    }
    
    
    func showStaticAlert(_ title: String, message: String) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: StringConstants.OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func reloadTableView() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.tableView.reloadData()
        })
    }
}

extension ContactsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getRowCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.Views.LIST_TABLE_VIEW_CELL) as! ListTableViewCell
        cell.configUI(contact: viewModel.getContact(for: indexPath))
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.getSectionTitles()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}

extension ContactsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


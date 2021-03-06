//
//  ViewController.swift
//  GJContactsDemo
//
//  Created by pvharsha on 2/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ContactsListViewController: UIViewController {
    
    //MARK:- iboutlets and variables
    @IBOutlet var tableView:UITableView!
    
    var viewModel: ContactsListViewModel!
    var searchController:UISearchController!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel:ContactsListViewModel) -> ContactsListViewController {
        
        let storyBoardRef = UIStoryboard.init(name: StringConstants.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: StringConstants.ViewControllers.CONTACTS_LIST_VC) as! ContactsListViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.listProtocol = viewController
        viewController.title = StringConstants.CONTACT
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem.init(title: StringConstants.GROUPS, style: .plain, target: self, action: #selector(ContactsListViewController.groups_buttonAction))
        leftBarButton.accessibilityIdentifier = StringConstants.GROUPS
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(ContactsListViewController.add_buttonAction))
        rightBarButton.accessibilityIdentifier = StringConstants.ADD
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.attachSearchController()
    }
    
    //MARK:- Custom Button Actions
    @objc func groups_buttonAction() {
        
        showStaticAlert(StringConstants.GROUPS_FUNCTIONALITY_TITLE, message: StringConstants.GROUPS_FUNCTIONALITY_MESSAGE)
    }
    
    @objc func add_buttonAction() {
        
        viewModel.invokeAddView()
    }
}

//MARK:- ViewModel Protocol functions
extension ContactsListViewController: ContactListViewModelProtocol {
    
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

//MARK:- TableView DataSource Protocol functions
extension ContactsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getRowCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: StringConstants.Views.LIST_TABLE_VIEW_CELL) as! ListTableViewCell
        cell.configUI(contact: viewModel.getContact(for: indexPath), indexPath: indexPath)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.getSectionTitles()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 16, y: 0, width: self.view.frame.size.width, height: 36))
        titleLabel.text = "  " + viewModel.getSectionHeaderTitle(section: section)
        titleLabel.font = UIFont.init(name: StringConstants.Fonts.APP_FONT_NAME, size: StringConstants.Fonts.APP_FONT_SIZE)
        titleLabel.backgroundColor = UIColor.init(named: StringConstants.Colors.LIST_VIEW_HEADER_COLOR)
        view.addSubview(titleLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
}

//MARK:- TableView Delegate Protocol functions
extension ContactsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.invokeDetailView(indexPath)
    }
}


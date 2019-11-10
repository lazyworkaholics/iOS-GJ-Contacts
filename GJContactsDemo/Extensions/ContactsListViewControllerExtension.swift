//
//  ContactsListViewControllerExtension.swift
//  GJContactsDemo
//
//  Created by pvharsha on 3/11/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

extension ContactsListViewController {
    
    func attachSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = StringConstants.SEARCH
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}


extension ContactsListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        viewModel.updateResults(with: searchString, isSearchEnabled: true)
    }
}

extension ContactsListViewController: UISearchControllerDelegate {
    
    func didDismissSearchController(_ searchController: UISearchController) {
        viewModel.updateResults(with: "", isSearchEnabled: false)
    }
}

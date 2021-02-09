//
//  LiveEventListTableViewController.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListTableViewController: UITableViewController {

    var listManager: LiveEventListManager!
    
    private lazy var dataSource = LiveEventListDataSource(listManager: listManager)
    
    // MARK: - Search Controller
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchResultsUpdater = LiveEventListSearchResultsUpdater(eventListManager: listManager)
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = searchResultsUpdater
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        
    }

}

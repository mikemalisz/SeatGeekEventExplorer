//
//  LiveEventListTableViewController.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListTableViewController: UITableViewController {

    var eventListManager: LiveEventListManager!
    
    private lazy var dataSource = LiveEventListDataSource(eventListManager: eventListManager)
    
    // MARK: - Search Controller
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchResultsUpdater = LiveEventListSearchResultsUpdater(eventListManager: eventListManager)
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = searchResultsUpdater
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        configureSearchController()
        eventListManager.refreshLiveEvents(with: nil)
    }

}

extension LiveEventListTableViewController: LiveEventListManagerDelegate {
    func liveEventListManager(_ listManager: LiveEventListManager, errorDidOccur error: Error) {
        print(error)
    }
    
    func liveEventListManager(_ listManager: LiveEventListManager, liveEventsDidUpdate events: [LiveEvent]) {
        tableView.reloadData()
    }
}

//
//  LiveEventListTableViewController.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListTableViewController: UITableViewController, Storyboarded {

    // MARK: - Dependencies
    
    var eventListManager: LiveEventListManager!
    
    private func configureEventListManager() {
        eventListManager.delegate = self
        eventListManager.refreshLiveEvents(with: nil)
    }
    
    var coordinator: MainCoordinator!
    
    var imageProvider: ImageRetrieving!
    
    // MARK: - Data Source
    
    private var dataSource: LiveEventListDataSource?
    
    // MARK: - Search Controller
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var searchResultsUpdater = LiveEventListSearchResultsUpdater(eventListManager: eventListManager)
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = searchResultsUpdater
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = LiveEventListDataSource(tableView: tableView,
                                             eventListManager: eventListManager,
                                             imageProvider: imageProvider)
        
        configureSearchController()
        configureEventListManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

}

// MARK: - List Manager Delegate

extension LiveEventListTableViewController: LiveEventListManagerDelegate {
    func liveEventListManager(_ listManager: LiveEventListManager, errorDidOccur error: Error) {
        print(error)
    }
    
    func liveEventListManager(_ listManager: LiveEventListManager, liveEventsDidUpdate events: [LiveEvent]) {
        tableView.reloadData()
    }
}

// MARK: - Table View Delegate

extension LiveEventListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let event = eventListManager.event(for: indexPath.row) else {
            return
        }
        coordinator.showDetail(for: event)
    }
}

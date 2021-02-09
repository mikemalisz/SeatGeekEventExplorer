//
//  LiveEventListSearchResultsUpdater.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListSearchResultsUpdater: NSObject {
    let eventListManager: LiveEventListManager
    
    init(eventListManager: LiveEventListManager) {
        self.eventListManager = eventListManager
        super.init()
    }
}

extension LiveEventListSearchResultsUpdater: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        eventListManager.refreshLiveEvents(with: query)
    }
}

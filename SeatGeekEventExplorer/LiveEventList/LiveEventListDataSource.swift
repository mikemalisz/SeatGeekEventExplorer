//
//  LiveEventListDataSource.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListDataSource: NSObject {
    private let eventListManager: LiveEventListManager
    
    private let tableView: UITableView
    
    init(tableView: UITableView, eventListManager: LiveEventListManager) {
        self.eventListManager = eventListManager
        self.tableView = tableView
        super.init()
        
        tableView.dataSource = self
    }
}

// MARK: - Table View Data Source

extension LiveEventListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventListManager.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LiveEventListTableViewCell.cellIdentifier,
            for: indexPath) as? LiveEventListTableViewCell
        else {
            assertionFailure("Expecting LiveEventListTableViewCell")
            return UITableViewCell()
        }
        
        guard let event = eventListManager.event(for: indexPath.row) else {
            return cell
        }
        
        cell.setTitle(with: event.title)
        cell.setLocation(withCity: event.venue.city, state: event.venue.state)
        cell.setDate(with: event.dateScheduled)
        
        return cell
    }
}

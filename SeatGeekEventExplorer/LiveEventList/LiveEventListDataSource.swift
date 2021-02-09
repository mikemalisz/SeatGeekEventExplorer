//
//  LiveEventListDataSource.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListDataSource: NSObject {
    let eventListManager: LiveEventListManager
    
    init(eventListManager: LiveEventListManager) {
        self.eventListManager = eventListManager
        super.init()
    }
}

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
        
        guard eventListManager.events.count < indexPath.row else {
            return cell
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

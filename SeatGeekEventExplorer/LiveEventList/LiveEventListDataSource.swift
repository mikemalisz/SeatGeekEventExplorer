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
        return UITableViewCell()
    }
}

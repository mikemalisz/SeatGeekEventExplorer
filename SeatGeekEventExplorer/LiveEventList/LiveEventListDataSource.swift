//
//  LiveEventListDataSource.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class LiveEventListDataSource: NSObject {
    private let tableView: UITableView
    
    private let eventListManager: LiveEventListManager
    
    private let imageProvider: ImageRetrieving
    
    init(tableView: UITableView, eventListManager: LiveEventListManager, imageProvider: ImageRetrieving) {
        self.tableView = tableView
        self.eventListManager = eventListManager
        self.imageProvider = imageProvider
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
        
        if let performer = event.performers.first {
            imageProvider.retrieveImage(at: performer.imagePath) { [weak cell] (result) in
                guard
                    case .success(let image) = result,
                    let roundedImage = image.roundedCorners()
                else {
                    return
                }
                cell?.setPreviewImage(with: roundedImage)
            }
        }
        
        return cell
    }
}

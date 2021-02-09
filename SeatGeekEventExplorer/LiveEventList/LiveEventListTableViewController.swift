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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    }

}

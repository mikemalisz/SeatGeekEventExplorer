//
//  MainCoordinator.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class MainCoordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventProvider = SeatGeekNetworkService()
        let eventListManager = LiveEventListManager(eventProvider: eventProvider,
                                                    storageProvider: DiskStorageService.shared)
        
        let controller = LiveEventListTableViewController()
        controller.eventListManager = eventListManager
        navigationController.pushViewController(controller, animated: false)
    }
    
    func showDetail(for event: LiveEvent) {
        
    }
}

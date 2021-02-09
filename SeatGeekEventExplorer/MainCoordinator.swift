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
        
        let controller = LiveEventListTableViewController.instantiate()
        controller.eventListManager = eventListManager
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
        
        // use large titles for subsequent view controllers
        navigationController.navigationBar.prefersLargeTitles = true
    }
    
    func showDetail(for event: LiveEvent) {
        let eventDetailsManager = LiveEventDetailsManager(event: event,
                                                          storageProvider: DiskStorageService.shared)
        
        let controller = LiveEventDetailsViewController.instantiate()
        controller.eventDetailsManager = eventDetailsManager
        navigationController.pushViewController(controller, animated: true)
    }
}

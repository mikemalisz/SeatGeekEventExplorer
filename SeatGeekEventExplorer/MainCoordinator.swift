//
//  MainCoordinator.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/8/21.
//

import UIKit

class MainCoordinator {
    private let networkProvider = SeatGeekNetworkService()
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListManager = LiveEventListManager(eventProvider: networkProvider,
                                                    storageProvider: DiskStorageService.shared)
        
        let controller = LiveEventListTableViewController.instantiate()
        controller.eventListManager = eventListManager
        controller.coordinator = self
        controller.imageProvider = networkProvider
        navigationController.pushViewController(controller, animated: false)
        
    }
    
    func showDetail(for event: LiveEvent) {
        let eventDetailsManager = LiveEventDetailsManager(event: event,
                                                          storageProvider: DiskStorageService.shared)
        
        let controller = LiveEventDetailsViewController.instantiate()
        controller.eventDetailsManager = eventDetailsManager
        navigationController.pushViewController(controller, animated: true)
    }
}

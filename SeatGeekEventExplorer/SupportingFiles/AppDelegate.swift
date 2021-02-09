//
//  AppDelegate.swift
//  SeatGeekEventExplorer
//
//  Created by Mike Maliszewski on 2/4/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootController = UINavigationController()
        
        // set up the coordinator
        coordinator = MainCoordinator(navigationController: rootController)
        coordinator?.start()
        
        // set up the applications root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        return true
    }


}


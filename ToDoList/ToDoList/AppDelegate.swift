//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 02.05.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let coreDataContainer = CoreDataStack.shared.persistentContainer!
        let service = ServiceImp(container: coreDataContainer)
        let coordinator = MainCoordinator(service: service)
        let taskManagerNavController = UINavigationController(rootViewController: coordinator.rootVC())
        
        window?.rootViewController = taskManagerNavController
        window?.makeKeyAndVisible()
        
        return true
    }
}

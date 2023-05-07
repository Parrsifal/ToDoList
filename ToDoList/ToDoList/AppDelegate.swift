//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 02.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let service = TaskListServiceImp()
        let coordinator = MainCoordinator(service: service)
        
        window?.rootViewController = coordinator.rootVC()
        window?.makeKeyAndVisible()
        return true
    }
}

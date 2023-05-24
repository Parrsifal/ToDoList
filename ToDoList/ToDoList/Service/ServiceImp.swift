//
//  ServiceImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import CoreData

final class ServiceImp: Service {
    var container: NSPersistentContainer!
    lazy var storage = StorageRepoImp(container: container)
    lazy var taskManagerService: TaskManagerService = TaskManagerServiceImp(storage: storage)
    
    init(container: NSPersistentContainer) {
        self.container = container
    }
}

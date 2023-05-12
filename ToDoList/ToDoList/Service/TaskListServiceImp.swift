//
//  TaskListServiceImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 05.05.2023.
//

import Foundation

final class TaskListServiceImp: TaskListService {
    
    var storage: StorageRepo
    
    init(storage: StorageRepo) {
        self.storage = storage
    }
    
    func getTasks() -> [Task] {
        return storage.getTasks()
    }
}

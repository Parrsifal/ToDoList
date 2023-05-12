//
//  AddEditTaskServiceImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

final class AddEditTaskServiceImp: AddEditTaskService {
    
    var storage: StorageRepo
    
    init(storage: StorageRepo) {
        self.storage = storage
    }
    
    func addTask(task: Task) {
        storage.addTask(task: task)
    }
}

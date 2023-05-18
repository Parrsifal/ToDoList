//
//  TaskMangerServiceImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 17.05.2023.
//

import Foundation

final class TaskManagerServiceImp: TaskManagerService {
    var storage: StorageRepo
    
    init(storage: StorageRepo) {
        self.storage = storage
    }
    
    func getTasks() -> [Task] {
        return storage.getTasks()
    }
    
    func addTask(task: Task) {
        storage.addTask(task: task)
    }
    
    func deleteTask(id: Int) {
        storage.deleteTask(id: id)
    }
    
    func completeTask(id: Int) {
        storage.completeTask(id: id)
    }
    
    func editTask(id: Int, title: String, description: String?) {
        storage.editTask(id: id, title: title, description: description)
    }
    
}

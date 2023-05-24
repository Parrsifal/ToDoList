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
    
    func deleteTask(id: UUID) {
        storage.deleteTask(id: id)
    }
    
    func updateTaskStatus(id: UUID) {
        storage.updateTaskStatus(id: id)
    }
    
    func editTask(id: UUID, title: String, description: String?) {
        storage.editTask(id: id, title: title, description: description)
    }
    
    func rearrengeTasks(firstTaskId: Int, secondTaskId: Int) {
        storage.rearrengeTasks(firstTaskId: firstTaskId, secondTaskId: secondTaskId)
    }
}

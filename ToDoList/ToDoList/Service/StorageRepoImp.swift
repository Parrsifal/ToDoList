//
//  StorageServiceImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

final class StorageRepoImp: StorageRepo {
    
    private var tasks: [Task] = []
    private var id = 0
    
    init() {
        populateTasks()
    }
    
    func addTask(task: Task) {
        tasks.append(task)
    }
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func editTask(id: Int, title: String, descirption: String?) {
        if let taskIndex = tasks.firstIndex(where: { $0.id == id } ) {
            tasks[taskIndex].title = title
            tasks[taskIndex].description = descirption
        }
    }
    
    func deleteTask(id: Int) {
        tasks.removeAll(where: { $0.id == id })
    }
    
    func completeTask(id: Int) {
        if let taskIndex = tasks.firstIndex(where: { $0.id == id }){
            tasks[taskIndex].isCompleted = true
        }
    }
}

extension StorageRepoImp {
    private func populateTasks() {
        tasks.append(Task(title: "Wake up broo", description: "Dont sleep again!!!"))
        tasks.append(Task(title: "Hello"))
    }
}

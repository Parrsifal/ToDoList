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
}

extension StorageRepoImp {
    private func populateTasks() {
        tasks.append(Task(title: "Wake up broo", description: "Dont sleep again!!!"))
        tasks.append(Task(title: "Hello"))
    }
}

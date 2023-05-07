//
//  TaskListServiceImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 05.05.2023.
//

import Foundation

final class TaskListServiceImp: TaskListService {
    
    private var tasks: [Task] = []
    private var id = 0
    
    init() {
        populateTasks()
    }
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func addTask(title: String, description: String?) {
        if let description = description {
            tasks.append(Task(id: id, title: title, description: description))
        } else {
            tasks.append(Task(id: id, title: title))
        }
    }
}

extension TaskListServiceImp {
    private func populateTasks() {
        tasks.append(Task(id: 2, title: "Wake up broo", description: "Dont sleep again!!!"))
        tasks.append(Task(id: 1, title: "Go eat bro", description: "I think this carrot is dead..."))
        tasks.append(Task(id: 23, title: "Hello"))
        tasks.append(Task(id: 1, title: "Go a bro", description: "fsdf"))
        tasks[0].isCompleted = true
    }
}

//
//  TaskManagerService.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 16.05.2023.
//

import Foundation

protocol TaskManagerService {
    var storage: StorageRepo { get set }
    func getTasks() -> [Task]
    func deleteTask(id: Int)
    func updateTaskStatus(id: Int)
    func editTask(id: Int, title: String, description: String?)
    func addTask(task: Task)
    func rearrengeTasks(firstTaskId: Int, secondTaskId: Int)
}


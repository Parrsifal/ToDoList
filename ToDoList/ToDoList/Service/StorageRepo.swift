//
//  StorageService.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

protocol StorageRepo {
    func getTasks() -> [Task]
    func addTask(task: Task)
    func editTask(id: UUID, title: String, description: String?)
    func deleteTask(id: UUID)
    func updateTaskStatus(id: UUID)
    func rearrengeTasks(firstTaskId: Int, secondTaskId: Int)
}

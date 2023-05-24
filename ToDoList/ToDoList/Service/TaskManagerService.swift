//
//  TaskManagerService.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 16.05.2023.
//

import Foundation

protocol TaskManagerService {
    func getTasks() -> [Task]
    func deleteTask(id: UUID)
    func updateTaskStatus(id: UUID)
    func editTask(id: UUID, title: String, description: String?)
    func addTask(task: Task)
    func rearrengeTasks(firstTaskId: Int, secondTaskId: Int)
}

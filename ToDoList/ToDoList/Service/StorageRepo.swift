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
    func editTask(id: Int, title: String, descirption: String?)
    func deleteTask(id: Int)
    func completeTask(id: Int)
}

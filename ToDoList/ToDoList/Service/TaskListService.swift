//
//  TaskListService.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 05.05.2023.
//

import Foundation

protocol TaskListService: AnyObject {
    var storage: StorageRepo { get set }
    func getTasks() -> [Task]
    func deleteTask(id: Int)
    func completeTask(id: Int)
}

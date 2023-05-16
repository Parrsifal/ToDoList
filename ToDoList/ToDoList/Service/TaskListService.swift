//
//  TaskListService.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 05.05.2023.
//

import Foundation

protocol TaskListService: AnyObject {
    func getTasks() -> [Task]
    var storage: StorageRepo { get set }
}

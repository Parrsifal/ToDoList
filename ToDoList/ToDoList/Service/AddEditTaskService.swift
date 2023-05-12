//
//  AddEditTaskService.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

protocol AddEditTaskService {
    var storage: StorageRepo { get set }
    func addTask(task: Task)
}

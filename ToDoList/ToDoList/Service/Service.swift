//
//  Service.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

protocol Service: AnyObject {
    var taskListService: TaskListService { get }
    var addEditTaskService: AddEditTaskService { get }
}

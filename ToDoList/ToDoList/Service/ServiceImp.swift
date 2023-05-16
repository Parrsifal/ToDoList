//
//  ServiceImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

final class ServiceImp: Service {
    lazy var storage = StorageRepoImp()
    lazy var taskListService: TaskListService = TaskListServiceImp(storage: storage)
    lazy var addEditTaskService: AddEditTaskService = AddEditTaskServiceImp(storage: storage)
}

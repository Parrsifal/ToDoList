//
//  AddEditTaskPresenterImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

final class AddEditTaskPresenterImp: AddEditTaskPresenter {
    
    var addEditTaskService: AddEditTaskService
    
    init(with service: AddEditTaskService) {
        self.addEditTaskService = service
    }
    
    func addTask(task: Task) {
        addEditTaskService.addTask(task: task)
    }
}

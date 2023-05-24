//
//  AddTaskBuilder.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 16.05.2023.
//

import Foundation

final class AddTaskBuilder{
    
    let service: Service
    let coordinator: Coordinator
    
    init(service: Service, coordinator: Coordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func buildAddNewTask(task: Task?) -> AddTaskViewController {
        
        let addTaskVC = AddTaskViewController(
            coordinator: coordinator
        )
        
        let presenter = AddEditTaskPresenterImp(with: service.taskManagerService, task: task, view: addTaskVC)
        addTaskVC.presenter = presenter
    
        return addTaskVC
    }
}

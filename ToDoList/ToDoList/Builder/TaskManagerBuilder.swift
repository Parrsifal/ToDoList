//
//  TaskManagerBuilder.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 10.05.2023.
//

import Foundation

final class TaskManagerBuilder {
    
    let service: Service
    let coordinator: Coordinator
    
    init(service: Service, coordinator: Coordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func buildTaskList() -> TaskListViewController {
        let presenter = TaskListPresenterImp(with: service.taskListService)
        
        let taskListVc = TaskListViewController(
            coordinator: coordinator,
            presenter: presenter
        )
        return taskListVc
    }
    
    func buildAddNewTask(task: Task?) -> AddTaskViewController {
        let presenter = AddEditTaskPresenterImp(with: service.addEditTaskService)
        
        let addTaskVC = AddTaskViewController(
            presenter: presenter,
            coordinator: coordinator,
            task: task
        )
        return addTaskVC
    }
}

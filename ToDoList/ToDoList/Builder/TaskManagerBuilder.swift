//
//  TaskManagerBuilder.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 10.05.2023.
//

import Foundation

final class TaskManagerBuilder {
    
    let service: TaskListService
    let coordinator: Coordinator
    
    init(service: TaskListService, coordinator: Coordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func buildTaskList() -> TaskListViewController {
        let presenter = TaskListPresenterImp(with: service as! TaskListServiceImp)
        
        let taskListVc = TaskListViewController(
            coordinator: coordinator,
            presenter: presenter
        )
        return taskListVc
    }
}

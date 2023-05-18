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
        
        let taskListVc = TaskListViewController(coordinator: coordinator)
        
        let presenter = TaskListPresenterImp(with: service.taskManagerService, view: taskListVc)
        taskListVc.presenter = presenter
        
        return taskListVc
    }
}

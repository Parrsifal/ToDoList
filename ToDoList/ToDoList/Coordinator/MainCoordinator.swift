//
//  MainCoordinator.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 04.05.2023.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
 
    let service: Service
    
    lazy var taskManagerBuilder: TaskManagerBuilder = {
        return TaskManagerBuilder(
            service: service,
            coordinator: self
        )
    }()
    
    lazy var addTaskBuilder: AddTaskBuilder = {
        return AddTaskBuilder(service: service,
                              coordinator: self
        )
    }()
    
    init(service: Service) {
        self.service = service
    }
    
    func rootVC() -> TaskListViewController {
        taskManagerBuilder.buildTaskList()
    }
    
    func navigateToAddNewTaskVC(from controller: UIViewController, task: Task?) {
        let nextVc = addTaskBuilder.buildAddNewTask(task: task)
        controller.navigationController?.pushViewController(nextVc, animated: true)
    }
    
    func navigateToRootVC(from controller: UIViewController) {
        controller.navigationController?.popToRootViewController(animated: true)
    }
}

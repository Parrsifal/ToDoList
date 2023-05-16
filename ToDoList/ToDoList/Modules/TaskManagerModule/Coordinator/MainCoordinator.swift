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
    
    lazy var builder: TaskManagerBuilder = {
        return TaskManagerBuilder(
            service: service,
            coordinator: self
        )
    }()
    
    init(service: Service) {
        self.service = service
    }
    
    func rootVC() -> TaskListViewController {
        builder.buildTaskList()
    }
    
    func navigateToAddNewTaskVC(from controller: UIViewController) {
        let nextVc = builder.buildAddNewTask()
        controller.navigationController?.pushViewController(nextVc, animated: true)
    }
    
    func navigateToRootVC(from controller: UIViewController) {
        controller.navigationController?.popToRootViewController(animated: true)
    }
}

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
    
    func navigateToaAddNewTaskVC(from: UIViewController) {
        let nextVc = builder.buildAddNewTask()
        from.navigationController?.pushViewController(nextVc, animated: true)
    }
    
    func navigateToRootVC(from: UIViewController) {
        from.navigationController?.popToRootViewController(animated: true)
    }
}

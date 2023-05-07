//
//  MainCoordinator.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 04.05.2023.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    
    let service: TaskListService
    
    lazy var builder: TaskManagerBuilder = {
        return TaskManagerBuilder(
            service: service,
            coordinator: self
        )
    }()
    
    init(service: TaskListService) {
        self.service = service
    }
    
    func rootVC() -> TaskListViewController {
        builder.buildTaskList()
    }
}

//
//  MainCoordinator.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 04.05.2023.
//

import Foundation
import UIKit

protocol Coordinator {
    func rootVC() -> TaskListViewController
    func addNewTask(from: UIViewController)
}

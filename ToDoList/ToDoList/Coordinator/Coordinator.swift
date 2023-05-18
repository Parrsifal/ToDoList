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
    func navigateToAddNewTaskVC(from: UIViewController, task: Task?)
    func navigateToRootVC(from: UIViewController)
}

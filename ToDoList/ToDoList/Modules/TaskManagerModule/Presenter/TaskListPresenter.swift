//
//  TaskListPresenter.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 05.05.2023.
//

import Foundation

protocol TaskListPresenter {
    func getTasks() -> [[Task]]
    func deleteTask(id: Int)
    func updateTaskStatus(id: Int)
}

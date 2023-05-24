//
//  TaskListPresenter.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 05.05.2023.
//

import Foundation

protocol TaskListPresenter {
    func getTasks() -> [[Task]]
    func deleteTask(id: UUID)
    func updateTaskStatus(id: UUID)
    func updateTaskListData()
    func rearrengeTasks(firstId: Int, secondId: Int)
}

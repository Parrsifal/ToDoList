//
//  TaskListPresenter.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 05.05.2023.
//

import Foundation

protocol TaskListPresenter {
    func getTasks() -> [[Task]]
  //  func addTask(task: Task)
   // func editTask(task: Task)
    func deleteTask(id: Int)
    func completeTask(id: Int)
}

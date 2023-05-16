//
//  TaskListPresenterImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import Foundation

final class TaskListPresenterImp: TaskListPresenter {
//    func addTask(task: Task) {
//
//    }
//
    
    private let taskListService: TaskListService
    
    init(with service: TaskListService) {
        taskListService = service
    }
    
    func getTasks() -> [[Task]] {
        let tasks = taskListService.getTasks()
        let activeTasks = tasks.filter { !$0.isCompleted }
        let completedTasks = tasks.filter { $0.isCompleted }
        return [activeTasks, completedTasks]
    }
    
    
    func deleteTask(id: Int) {
        taskListService.deleteTask(id: id)
    }
    
    func completeTask(id: Int) {
        taskListService.completeTask(id: id)
    }
}

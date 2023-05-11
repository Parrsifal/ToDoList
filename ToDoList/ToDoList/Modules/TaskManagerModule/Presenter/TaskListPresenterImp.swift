//
//  TaskListPresenterImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import Foundation

final class TaskListPresenterImp: TaskListPresenter {
    
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
}

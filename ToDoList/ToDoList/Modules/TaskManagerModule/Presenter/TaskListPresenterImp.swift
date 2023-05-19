//
//  TaskListPresenterImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import Foundation

final class TaskListPresenterImp: TaskListPresenter {
    
    private let taskManagerService: TaskManagerService
    private unowned let view: TaskListView
    
    init(with service: TaskManagerService, view: TaskListView) {
        self.taskManagerService = service
        self.view = view
    }
    
    func getTasks() -> [[Task]] {
        let tasks = taskManagerService.getTasks()
        let activeTasks = tasks.filter { !$0.isCompleted }
        let completedTasks = tasks.filter { $0.isCompleted }
        return [activeTasks, completedTasks]
    }
    
    func deleteTask(id: Int) {
        taskManagerService.deleteTask(id: id)
        view.updateTaskListData(tasks: self.getTasks())
    }
    
    func updateTaskStatus(id: Int) {
        taskManagerService.updateTaskStatus(id: id)
        view.updateTaskListData(tasks: self.getTasks())
    }
    
    func rearrengeTasks(firstId: Int, secondId: Int) {
        taskManagerService.rearrengeTasks(firstTaskId: firstId, secondTaskId: secondId)
        view.updateTaskListData(tasks: self.getTasks())
    }
    
    func updateTaskListData() {
        view.updateTaskListData(tasks: self.getTasks())
    }
}

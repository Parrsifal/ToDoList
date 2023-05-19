//
//  AddEditTaskPresenterImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation
import UIKit

final class AddEditTaskPresenterImp: AddEditTaskPresenter {
    
    private let taskManagerService: TaskManagerService
    private var task: Task?
    private unowned let view: AddTaskView
    
    init(with service: TaskManagerService, task: Task?, view: AddTaskView) {
        self.taskManagerService = service
        self.task = task
        self.view = view
    }
    
    func getTask() -> Task? {
        return self.task
    }
        
    func buttonDidTouch(title: String, description: String?) {
        if let task {
            taskManagerService.editTask(id: task.id, title: title, description: description)
        } else {
            taskManagerService.addTask(task: Task(title: title, description: description))
        }
    }
    
    func setUpScreenMode(title: String, description: String?) {
        if let task {
            view.setUpEditScreenMode(title: task.title, description: task.description)
        } else {
            view.setUpAddScreenMode()
        }
        
    }

    func inputFieldsWasChanged(_ title: String, _ description: String?) {
        
        let isValidTitle = (title.count > 4 && title.count < 15)
        var isHiden = isValidTitle
        
        if let description {
            let isValidDescription = description.count == 0 || (description.count > 4 && description.count < 15 )
            isHiden = isValidTitle && isValidDescription
        }
        view.showButton(isHiden: isHiden)
    }
    
}

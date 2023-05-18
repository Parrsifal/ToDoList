//
//  AddEditTaskPresenterImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation
import UIKit

final class AddEditTaskPresenterImp: AddEditTaskPresenter {
    
    func getTask() -> Task? {
        return self.task
    }
    
    private var taskManagerService: TaskManagerService
    private var task: Task?
    private  var view: AddTaskView
    
    init(with service: TaskManagerService, task: Task?, view: AddTaskView) {
        self.taskManagerService = service
        self.task = task
        self.view = view
    }
    
    func setView(view : AddTaskView){
        self.view = view
    }
    
    func addTask(task: Task) {
        taskManagerService.addTask(task: task)
    }
    
    func editTask(title: String, description: String?) {
        taskManagerService.editTask(id: task!.id, title: title, description: description)
        view.reloadStatus()
    }
    
    func setUpScreenMode() -> TaskDetailsScreenMode {
        return task != nil ? .editTask : .addTask
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

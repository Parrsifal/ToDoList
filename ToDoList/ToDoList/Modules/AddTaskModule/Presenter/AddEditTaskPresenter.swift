//
//  AddEditTaskPresenter.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

protocol AddEditTaskPresenter {
    func addTask(task: Task)
    func editTask(title: String, description: String?)
    func setView(view : AddTaskView)
    func setUpScreenMode() -> TaskDetailsScreenMode
    func getTask() -> Task?
    func inputFieldsWasChanged(_ title: String, _ description: String?)
}

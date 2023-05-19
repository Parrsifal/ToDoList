//
//  AddEditTaskPresenter.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

protocol AddEditTaskPresenter {
    func getTask() -> Task?
    func inputFieldsWasChanged(_ title: String, _ description: String?)
    func setUpScreenMode(title: String, description: String?)
    func buttonDidTouch(title: String, description: String?)
}

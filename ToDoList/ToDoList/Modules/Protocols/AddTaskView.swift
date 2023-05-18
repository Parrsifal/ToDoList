//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 17.05.2023.
//

import Foundation

protocol AddTaskView: AnyObject {
    func setUpScreenMode()
    func reloadStatus()
    func showButton(isHiden: Bool)
}

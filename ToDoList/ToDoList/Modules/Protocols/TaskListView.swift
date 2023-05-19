//
//  TaskListView.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 17.05.2023.
//

import Foundation

protocol TaskListView : AnyObject {
    func updateTaskListData(tasks: [[Task]])
}

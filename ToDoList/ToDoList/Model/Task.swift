//
//  Task.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import Foundation

struct Task {
    var id: Int
    var title: String
    var description: String?
    var isCompleted: Bool = false
}

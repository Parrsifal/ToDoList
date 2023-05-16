//
//  Task.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import Foundation

struct Task {
    static var currentMaxId = 0
    
    var id: Int
    var title: String
    var description: String?
    var isCompleted: Bool = false
    
    init(title: String, description: String? = nil) {
        Task.currentMaxId += 1
        self.id = Task.currentMaxId
        self.title = title
        self.description = description
    }
}

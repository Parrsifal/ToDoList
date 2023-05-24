//
//  Task.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import Foundation

struct Task {
    
    var id: UUID
    var title: String
    var description: String?
    var isCompleted: Bool = false
    var actionDate: Date!
    
    init(title: String, description: String? = nil, actionDate: Date? = Date()) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.actionDate = actionDate
    }
}

extension Task {
    init(taskEntity: TaskEntity){
        self.actionDate = taskEntity.actionDate
        self.id = taskEntity.id ?? UUID()
        self.title = taskEntity.title ?? ""
        self.description = taskEntity.taskDescription
        self.isCompleted = taskEntity.isCompleted
    }
}

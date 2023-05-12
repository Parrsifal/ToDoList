//
//  Task.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 03.05.2023.
//

import Foundation

struct Task {
    static var currentMaxId = 0
    
    var id: Int{
        Task.currentMaxId += 1
        return Task.currentMaxId
    }
    var title: String
    var description: String?
    var isCompleted: Bool = false
}

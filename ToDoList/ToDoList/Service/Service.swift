//
//  Service.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import Foundation

protocol Service: AnyObject {
    var taskManagerService: TaskManagerService { get }
}

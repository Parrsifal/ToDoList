//
//  StorageServiceImp.swift
//  ToDoList
//
//  Created by Dmitrii Sorochin on 12.05.2023.
//

import CoreData
import UIKit

final class StorageRepoImp: StorageRepo {
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var fetchedTasks = [TaskEntity]()
    private var id = 0
    
    func addTask(task: Task) {
        createObject(id: task.id, title: task.title, description: task.description)
    }
    
    func getTasks() -> [Task] {
        fetchTasks()
        return fetchedTasks.map{ Task(taskEntity: $0) }
    }
    
    func editTask(id: UUID, title: String, description: String?) {
        guard let taskIndex = fetchedTasks.firstIndex(where: { $0.id == id } ) else { return }
        fetchedTasks[taskIndex].title = title
        fetchedTasks[taskIndex].taskDescription = description
        do {
            try self.context.save()
        } catch {
            fatalError("Cant edit the task")
        }
    }
    
    func deleteTask(id: UUID) {
        guard let taskToDelete = fetchedTasks.first(where: { $0.id == id }) else { return }
        do {
            self.context.delete(taskToDelete)
            try self.context.save()
        } catch {
            fatalError("Cant delete the task")
        }
    }
    
    func updateTaskStatus(id: UUID) {
        
        guard let taskIndex = fetchedTasks.firstIndex(where: { $0.id == id }) else { return }
        fetchedTasks[taskIndex].isCompleted.toggle()
        do {
            try self.context.save()
        } catch {
            fatalError("Cant change task status")
        }
    }
    
    func rearrengeTasks(firstTaskId: Int, secondTaskId: Int) {
        
        let sourceTask = self.fetchedTasks.remove(at: firstTaskId)
        self.fetchedTasks.insert(sourceTask, at: secondTaskId)
        
        for task in fetchedTasks {
            task.actionDate = Date()
        }
        
        try! self.context.save()
    }
    
    private func createObject(id: UUID, title: String, description: String?) {
        let newTask = TaskEntity(context: self.context)
        newTask.id = id
        newTask.title = title
        newTask.taskDescription = description
        newTask.isCompleted = false
        newTask.actionDate = Date()
        
        do {
            try self.context.save()
        } catch {
            fatalError("Catn save the data in context")
        }
    }
    
    private func fetchTasks() {
        do {
            self.fetchedTasks = try context.fetch(TaskEntity.fetchRequest())
            self.fetchedTasks.sort(by: { $0.actionDate! < $1.actionDate! })
        } catch {
            fatalError("Can't fetch data from core data")
        }
    }
}

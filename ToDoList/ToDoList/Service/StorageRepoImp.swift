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
    private var tasks: [Task] = []
    private var id = 0
    
    init() {
        fetchTasks()
    }
    
    func addTask(task: Task) {
        createObject(id: Int64(task.id), title: task.title, description: task.description)
        fetchTasks()
    }
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func editTask(id: Int, title: String, description: String?) {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(id))
        
        do {
            let fetchedTasks = try context.fetch(fetchRequest)
            if let taskToEdit = fetchedTasks.first {
                taskToEdit.title = title
                taskToEdit.taskDescription = description
                try self.context.save()
            }
        } catch {
            fatalError("Cant edit the task")
        }
        fetchTasks()
    }
    
    func deleteTask(id: Int) {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        
        do {
            let fetchedTasks = try context.fetch(fetchRequest)
            if let taskEntityToDelete = fetchedTasks.first {
                self.context.delete(taskEntityToDelete)
                try self.context.save()
            }
        } catch {
            fatalError("Catn save the data in context")
        }
        fetchTasks()
    }
    
    func updateTaskStatus(id: Int) {
        let fetchRequest: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", Int64(id))
        do {
            let fetchedTasks = try context.fetch(fetchRequest)
            if let taskEntity = fetchedTasks.first {
                taskEntity.isCompleted.toggle()
                try self.context.save()
            }
        } catch {
            fatalError("Cant update task status")
        }
        fetchTasks()
    }
    
    func rearrengeTasks(firstTaskId: Int, secondTaskId: Int) {
        self.tasks = try! context.fetch(TaskEntity.fetchRequest()).map({ Task(taskEntity: $0) })
        var foo = try! context.fetch(TaskEntity.fetchRequest())

        guard let firstIndex = self.tasks.firstIndex(where: { $0.id == firstTaskId }) else { return }
        guard let secondIndex = self.tasks.firstIndex(where: { $0.id == secondTaskId }) else { return }

        foo.swapAt(firstIndex, secondIndex)
        for id in 0..<tasks.count {
            foo[id].id = Int64(tasks[id].id)
        }
        foo.forEach{ print( $0 ) }
        foo.sort(by: { $0.id < $1.id })
        try! self.context.save()
        fetchTasks()
    }

    private func createObject(id: Int64, title: String, description: String?) {
        let newTask = TaskEntity(context: self.context)
        newTask.id = Int64(Task.currentMaxId)
        newTask.title = title
        newTask.taskDescription = description
        newTask.isCompleted = false
        
        do {
            try self.context.save()
        } catch {
            fatalError("Catn save the data in context")
        }
    }
    
    private func fetchTasks() {
        do {
            self.tasks = try context.fetch(TaskEntity.fetchRequest()).map{ Task(taskEntity: $0) }
            self.tasks.sort(by: { $0.id < $1.id })
        } catch {
            fatalError("Can't fetch data from core data")
        }
    }
}

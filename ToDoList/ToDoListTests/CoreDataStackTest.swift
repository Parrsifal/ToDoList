//
//  CoreDataStackTest.swift
//  ToDoListTests
//
//  Created by Dmitrii Sorochin on 24.05.2023.
//

import CoreData
import ToDoList

class CoreDataStackTest {
    
    static let shared = CoreDataStackTest()
    let persistentContainer: NSPersistentContainer!
    let persistentDescription: NSPersistentStoreDescription!
    let mainContext: NSManagedObjectContext!
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoListModel")
        persistentDescription = persistentContainer.persistentStoreDescriptions.first
        persistentDescription.type = NSInMemoryStoreType
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        
    }
    
    func clearAll() {
        do {
            let tasks = try persistentContainer.viewContext.fetch(TaskEntity.fetchRequest())
            for task in tasks {
                persistentContainer.viewContext.delete(task)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}

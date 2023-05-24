//
//  CoreDataStack.swift
//  ToDoListTests
//
//  Created by Dmitrii Sorochin on 24.05.2023.
//

import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer!
    let mainContext: NSManagedObjectContext!
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "ToDoListModel")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        mainContext = persistentContainer.viewContext
        
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

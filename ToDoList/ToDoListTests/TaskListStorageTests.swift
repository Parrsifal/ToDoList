//
//  TaskListPresenterTests.swift
//  ToDoListTests
//
//  Created by Dmitrii Sorochin on 23.05.2023.
//

import XCTest
@testable import ToDoList

final class TaskListStorageTests: XCTestCase {
    
    var storage: StorageRepo!
    override func setUp() {
        storage = StorageRepoImp(container: CoreDataStackTest.shared.persistentContainer)
        continueAfterFailure = false
    }
    
    override func tearDown() {
        storage = nil
        CoreDataStackTest.shared.clearAll()
    }
    
    func testAddTask() {
        let task = Task(title: "Test", description: "test")
        XCTAssertTrue(storage.getTasks().isEmpty, "Storage is not empty")
        storage.addTask(task: task)
        XCTAssertFalse(storage.getTasks().isEmpty, "Task didn't add")
        print("testAddTask --- PASSED")
    }
    
    func testEditTask() {
        let task = Task(title: "test")
        storage.addTask(task: task)
        XCTAssertEqual(storage.getTasks().first!.title, "test")
        storage.editTask(id: task.id, title: "edited", description: nil)
        XCTAssertEqual(storage.getTasks().first!.title, "edited" )
        print("testEditTASK --- PASSED")
    }
    
    func testDeleteTask() {
        let task = Task(title: "test")
        storage.addTask(task: task)
        storage.deleteTask(id: storage.getTasks().first!.id)
        XCTAssertTrue(storage.getTasks().isEmpty, "Storage is not empty")
        print("testDeleteTask --- PASSED")
    }
    
    func testUpdateTaskStatus() {
        let task = Task(title: "test")
        storage.addTask(task: task)
        XCTAssertTrue(storage.getTasks().first!.isCompleted == false, "Status shoudn't be completed!" )
        print("testUpdateTaskStatus --- PASSED")
    }
    
    func testRearengeTasks() {
        let sourceTask = Task(title: "sourceTask")
        storage.addTask(task: sourceTask)
        let targetTask = Task(title: "targetTask")
        storage.addTask(task: targetTask)
        XCTAssertTrue(storage.getTasks().first!.id == sourceTask.id)
        guard let firstTaskIndex = storage.getTasks().firstIndex(where: { $0.id == sourceTask.id }) else { return }
        guard let secondTaskIndex = storage.getTasks().firstIndex(where: { $0.id == targetTask.id }) else { return }
        storage.rearrengeTasks(firstTaskId: firstTaskIndex, secondTaskId: secondTaskIndex)
        XCTAssertTrue(storage.getTasks().first!.id == targetTask.id, "Task does not moved to target index")
        print("testRearengeTasks --- PASSED")
    }
}

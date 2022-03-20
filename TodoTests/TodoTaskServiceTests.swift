//
//  TodoTaskServiceTests.swift
//  TodoTests
//
//  Created by Jaime Jazareno III on 3/20/22.
//

import XCTest
@testable import Todo

class TodoTaskServiceTests: XCTestCase {
    var service: TodoTaskServiceable?

    override func setUpWithError() throws {
        service = TodoTaskMockService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func testGetList() throws {
        let tasks = try! service!.getList()

        XCTAssertEqual((service as! TodoTaskMockService).sampleTodoTasks, tasks)
    }

    func testAddTask() throws {
        var newTask = TodoTask(title: "New task",
                               description: "Some description here",
                               status: .active,
                               userId: 0)
        let maxId = (service as! TodoTaskMockService).sampleTodoTasks.map { $0.id }.max() ?? 0
        newTask.id = maxId + 1
        let tasks = service!.add(task: newTask)

        XCTAssertEqual((service as! TodoTaskMockService).sampleTodoTasks, tasks)
        XCTAssert(tasks.contains(newTask))
    }

    func testEditTask() throws {
        var task = (service as! TodoTaskMockService).sampleTodoTasks.last!
        let newTitle = "New title"
        task.title = newTitle
        let tasks = service!.edit(task: task)

        XCTAssertEqual((service as! TodoTaskMockService).sampleTodoTasks, tasks)
        XCTAssertEqual((service as! TodoTaskMockService).sampleTodoTasks.last!.title, newTitle)
    }

    func testDeleteTask() throws {
        let task = (service as! TodoTaskMockService).sampleTodoTasks.last!
        XCTAssertEqual((service as! TodoTaskMockService).sampleTodoTasks.count, 5)
        let tasks = service!.delete(task: task)

        XCTAssertEqual((service as! TodoTaskMockService).sampleTodoTasks.count, 4)
        XCTAssertEqual((service as! TodoTaskMockService).sampleTodoTasks, tasks)
        XCTAssertFalse(tasks.contains(task))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  TodoTaskMockService.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/20/22.
//

import Foundation

class TodoTaskMockService: TodoTaskServiceable {
    var sampleTodoTasks = [
        TodoTask(id: 0, title: "Task 1", description: "Some description here...", status: .active, userId: 0),
        TodoTask(id: 1, title: "Task 2", description: "Some description here...", status: .active, userId: 0),
        TodoTask(id: 2, title: "Task 3", description: "Some description here...", status: .active, userId: 0),
        TodoTask(id: 3, title: "Task 4", description: "Some description here...", status: .active, userId: 0),
        TodoTask(id: 4, title: "Task 5", description: "Some description here...", status: .active, userId: 0),
    ]

    func getList() throws -> [TodoTask] {
        sampleTodoTasks
    }

    func add(task: TodoTask) -> [TodoTask] {
        sampleTodoTasks.append(task)

        return sampleTodoTasks
    }

    func delete(task: TodoTask) -> [TodoTask] {
        sampleTodoTasks.removeAll(where: { $0.id == task.id })

        return sampleTodoTasks
    }

    func edit(task: TodoTask) -> [TodoTask] {
        guard let editedTaskIndex = sampleTodoTasks.enumerated()
                .first(where: { $0.element.id == task.id })?.offset else { return [] }
        sampleTodoTasks[editedTaskIndex] = task

        return sampleTodoTasks
    }
}

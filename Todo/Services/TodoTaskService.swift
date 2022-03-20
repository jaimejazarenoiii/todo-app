//
//  TodoTaskService.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import Foundation

struct TodoTaskSerice: TodoTaskServiceable, Saveable {
    func getList() throws -> [TodoTask] {
        guard let currentUser = world.authService.getCurrentUser() else { return [] }
        let tasks = try FileLoader().loadFile(type: TodoTask.self, fromFileNamed: "tasks")
        return tasks.filter { $0.userId == currentUser.id }
    }

    func add(task: TodoTask) -> [TodoTask] {
        guard let currentUser = world.authService.getCurrentUser() else { return [] }
        var newTask = task
        var tasks: [TodoTask] = try! FileLoader().loadFile(type: TodoTask.self, fromFileNamed: "tasks")

        let maxId = tasks.map { $0.id }.max() ?? 0
        newTask.id = maxId + 1
        newTask.userId = currentUser.id

        tasks.append(newTask)

        saveToJson(type: TodoTask.self, objects: tasks, fileName: "tasks")

        return tasks.filter { $0.userId == currentUser.id }
    }

    func delete(task: TodoTask) -> [TodoTask] {
        guard let currentUser = world.authService.getCurrentUser() else { return [] }
        var tasks = try! FileLoader().loadFile(type: TodoTask.self, fromFileNamed: "tasks")
        tasks.removeAll(where: { $0.id == task.id })

        saveToJson(type: TodoTask.self, objects: tasks, fileName: "tasks")

        return tasks.filter { $0.userId == currentUser.id }
    }

    func edit(task: TodoTask) -> [TodoTask] {
        guard let currentUser = world.authService.getCurrentUser() else { return [] }
        var tasks = try! FileLoader().loadFile(type: TodoTask.self, fromFileNamed: "tasks")
        guard let oldTask = tasks.enumerated().first(where: { $0.element.id == task.id }) else { return tasks }
        tasks[oldTask.offset] = task

        saveToJson(type: TodoTask.self, objects: tasks, fileName: "tasks")

        return tasks.filter { $0.userId == currentUser.id }
    }
}

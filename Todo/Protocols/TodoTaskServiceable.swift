//
//  TodoTaskServiceable.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import Foundation

protocol TodoTaskServiceable {
    func getList() throws -> [TodoTask]
    func add(task: TodoTask) -> [TodoTask]
    func delete(task: TodoTask) -> [TodoTask]
    func edit(task: TodoTask) -> [TodoTask]
}

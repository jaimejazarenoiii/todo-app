//
//  TodoTaskAction.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import Foundation
import ReSwift

enum TodoTaskAction: Action {
    case getList
    case add(task: TodoTask)
    case getCurrentUser
    case edit(task: TodoTask)
    case delete(task: TodoTask)
    case set(formState: FormState)
}

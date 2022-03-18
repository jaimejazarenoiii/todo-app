//
//  TodoTaskState.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import Foundation

struct TodoTaskState {
    var tasks: [TodoTask] = []
    var error: Error?
    var currentUser: User?
    var selectedTask: TodoTask?
    var formState: FormState = .none
}

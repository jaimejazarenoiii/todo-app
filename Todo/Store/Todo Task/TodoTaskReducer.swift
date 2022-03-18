//
//  TodoTaskReducer.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import ReSwift

func todoTaskReducer(action: Action, state: TodoTaskState?) -> TodoTaskState {
    var state = state ?? TodoTaskState()
    guard let action = action as? TodoTaskAction else { return state }
    switch action {
    case .getList:
        do {
            state.tasks = try world.todoTaskService.getList()
        } catch(let err) {
            state.error = err
        }
    case .add(let task):
        let tasks = world.todoTaskService.add(task: task)
        state.tasks = tasks
        state.formState = .done
    case .getCurrentUser:
        state.currentUser = world.authService.getCurrentUser()
    case .delete(let task):
        let tasks = world.todoTaskService.delete(task: task)
        state.tasks = tasks
    case .edit(let task):
        let tasks = world.todoTaskService.edit(task: task)
        state.tasks = tasks
        state.formState = .done
    case .set(let formState):
        state.formState = formState
    }

    return state
}

//
//  AppAction.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import ReSwift

enum AppAction: Action {
    case auth(action: AuthAction)
    case todoTask(action: TodoTaskAction)
}

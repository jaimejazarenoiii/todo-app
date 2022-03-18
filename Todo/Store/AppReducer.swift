//
//  AppReducer.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(authState: authReducer(action: action,
                                    state: state?.authState),
             todoTaskState: todoTaskReducer(action: action, state: state?.todoTaskState)
    )
}

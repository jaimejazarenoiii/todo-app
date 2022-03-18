//
//  Store.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import ReSwift

let world = World()

let store = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: [])

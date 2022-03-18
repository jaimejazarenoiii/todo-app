//
//  ApplicationCoordinator.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import UIKit
import ReSwift

class ApplicationCoordinator: Coordinator, StoreSubscriber {
    typealias StoreSubscriberStateType = AuthState
    private var prevStateOfAuth: Bool = false

    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        store.subscribe(self) { $0.select({ $0.authState }) }
    }

    deinit {
        store.unsubscribe(self)
    }

    func start() {
        store.dispatch(AuthAction.checkIfAuthenticated)
    }

    func newState(state: AuthState) {
        guard prevStateOfAuth != state.isLoggedIn else { return }
        prevStateOfAuth = state.isLoggedIn ?? false
        state.isLoggedIn ?? false ? goToHomeScene() : setOnboardingScene()
    }
}

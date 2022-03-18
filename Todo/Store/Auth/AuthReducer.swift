//
//  AuthReducer.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import Foundation
import ReSwift

func authReducer(action: Action, state: AuthState?) -> AuthState {
    var state = state ?? AuthState()
    guard let action = action as? AuthAction else { return state }

    switch action {
    case .signin(let email, let password):
        do {
            let user = try world.authService.signIn(email: email, password: password)
            UserDefaults.standard.set(user?.id, forKey: "userId")
            state.isLoggedIn = true
        } catch(let err) {
            state.authError = err
        }
    case .signup(let name, let email, let password):
        do {
            let user = try world.authService.signUp(name: name, email: email, password: password)
            UserDefaults.standard.set(user?.id, forKey: "userId")
            state.isLoggedIn = true
        } catch(let err) {
            state.authError = err
        }
    case .checkIfAuthenticated:
        state.isLoggedIn = UserDefaults.standard.value(forKey: "userId") != nil
    case .signout:
        UserDefaults.standard.set(nil, forKey: "userId")
        state.isLoggedIn = false
    case .clearError:
        state.authError = nil
    }

    return state
}

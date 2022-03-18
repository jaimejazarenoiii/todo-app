//
//  AuthAction.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import Foundation
import ReSwift

enum AuthAction: Action {
    case signin(email: String, password: String)
    case signup(name: String, email: String, password: String)
    case checkIfAuthenticated
    case clearError
    case signout
}

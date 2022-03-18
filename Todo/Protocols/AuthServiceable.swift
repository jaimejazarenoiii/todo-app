//
//  AuthServiceable.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import Foundation

protocol AuthServiceable {
    func signIn(email: String, password: String) throws -> User?
    func signUp(name: String, email: String, password: String) throws -> User?
    func getCurrentUser() -> User?
}

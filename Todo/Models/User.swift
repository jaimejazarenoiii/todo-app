//
//  User.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import Foundation

struct User: Codable, Equatable {
    var id: Int
    var name: String
    var email: String
    var password: String
}

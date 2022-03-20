//
//  Task.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import Foundation

struct TodoTask: Codable, Equatable {
    var id: Int = 0
    var title: String
    var description: String
    var status: Status = .active
    var userId: Int = -1
}

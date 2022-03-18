//
//  Coordinator.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import UIKit

protocol Coordinator {
    var window: UIWindow { get set }

    func start()
}

//
//  ApplicationCoordinator+TaskForm.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import Foundation

extension ApplicationCoordinator: TaskFormViewControllerDelegate {
    func successfullySaved(source: TaskFormViewController) {
        source.dismiss(animated: true, completion: nil)
    }
}

//
//  ApplicationCoordinator+Home.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import Foundation

extension ApplicationCoordinator: HomeViewControllerDelegate {
    func didTapAddButton(source: HomeViewController) {
        presentTaskForm(source: source, action: .add, selectedTask: nil)
    }

    func didTapEditButton(source: HomeViewController, selectedTask: TodoTask) {
        presentTaskForm(source: source, action: .edit, selectedTask: selectedTask)
    }

    func didTapSignout(source: WelcomeHeaderView) {
        store.dispatch(AuthAction.signout)
    }
}

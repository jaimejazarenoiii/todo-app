//
//  ApplicationCoordinator+Navigation.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit

extension ApplicationCoordinator {
    func setOnboardingScene() {
        let vc = OnboardingViewController()
        guard let navigationController = window.rootViewController as? UINavigationController,
              !(navigationController.visibleViewController?.isKind(of: OnboardingViewController.self) ?? false) else { return }
        vc.delegate = self
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }

    func goToSigninScene() {
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        let vc = SigninViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    func goToSignupScene() {
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        let vc = SignupViewController()
        navigationController.pushViewController(vc, animated: true)
    }

    func goToHomeScene() {
        let vc = HomeViewController()
        guard let navigationController = window.rootViewController as? UINavigationController,
        !(navigationController.visibleViewController?.isKind(of: HomeViewController.self) ?? false) else { return }
        vc.delegate = self
        window.rootViewController = UINavigationController(rootViewController: vc)
        window.makeKeyAndVisible()
    }

    func presentTaskForm(source: HomeViewController, action: MutateAction, selectedTask: TodoTask?) {
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        let vc = TaskFormViewController(action: action, selectedTask: selectedTask)
        vc.delegate = self
        navigationController
            .present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}

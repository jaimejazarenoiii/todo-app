//
//  ApplicationCoordinator+Onboarding.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit

extension ApplicationCoordinator: OnboardingViewControllerDelegate {
    func didTapSignin(source: OnboardingViewController) {
        goToSigninScene()
    }

    func didTapSignup(source: OnboardingViewController) {
        goToSignupScene()
    }

    func didReauthenticate(source: OnboardingViewController) {
        goToHomeScene()
    }
}

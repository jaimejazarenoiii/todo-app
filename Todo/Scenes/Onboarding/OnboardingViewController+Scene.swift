//
//  OnboardingViewController+Scene.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit

extension OnboardingViewController {
    func setupScene() {
        setupTextLabel()
        setupSigninButton()
        setupSignupButton()
    }

    private func setupTextLabel() {
        textLabel.text = "Todo App"
        textLabel.font = UIFont.systemFont(ofSize: 34)
        textLabel.textAlignment = .center

        view.addSubview(textLabel)

        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120).priority(.high)
            make.left.right.equalToSuperview()
        }
    }

    private func setupSigninButton() {
        signinButton.setTitle("Sign in", for: .normal)
        signinButton.backgroundColor = .blue

        view.addSubview(signinButton)

        signinButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(40)
            make.top.lessThanOrEqualTo(textLabel.snp.bottom).priority(.low)
            make.centerY.greaterThanOrEqualTo(view.snp.centerY).offset(40)
        }
    }

    private func setupSignupButton() {
        signupButton.setTitle("Sign up", for: .normal)
        signupButton.backgroundColor = .blue

        view.addSubview(signupButton)

        signupButton.snp.makeConstraints { make in
            make.left.right.equalTo(signinButton)
            make.top.equalTo(signinButton.snp.bottom).offset(10)
            make.bottom.greaterThanOrEqualToSuperview().inset(30)
        }
    }
}

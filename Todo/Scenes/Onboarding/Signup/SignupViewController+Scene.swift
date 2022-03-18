//
//  SignupViewController+Scene.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit

extension SignupViewController {
    func setupScene() {
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupSignupButton()
    }

    private func setupNameTextField() {
        nameTextField.placeholder = "Enter name"
        nameTextField.font = .systemFont(ofSize: 24)

        view.addSubview(nameTextField)

        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.left.right.equalToSuperview().inset(40)
        }
    }

    private func setupEmailTextField() {
        emailTextField.placeholder = "Enter email address"
        emailTextField.font = .systemFont(ofSize: 24)
        emailTextField.autocapitalizationType = .none

        view.addSubview(emailTextField)

        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.left.right.equalTo(nameTextField)
        }
    }

    private func setupPasswordTextField() {
        passwordTextField.placeholder = "Enter password"
        passwordTextField.font = .systemFont(ofSize: 24)
        passwordTextField.isSecureTextEntry = true

        view.addSubview(passwordTextField)

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.equalTo(emailTextField)
        }
    }

    private func setupConfirmPasswordTextField() {
        confirmPasswordTextField.placeholder = "Confirm password"
        confirmPasswordTextField.font = .systemFont(ofSize: 24)
        confirmPasswordTextField.isSecureTextEntry = true

        view.addSubview(confirmPasswordTextField)

        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalTo(emailTextField)
        }
    }

    private func setupSignupButton() {
        signupButton.setTitle("Sign up", for: .normal)

        view.addSubview(signupButton)

        signupButton.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(30)
            make.left.right.equalTo(passwordTextField)
            make.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }
}

//
//  SigninViewController+Scene.swift
//  Todo
//
//  Created by Jaime Jazareno III on 3/18/22.
//

import UIKit

extension SigninViewController {
    func setupScene() {
        setupEmailTextField()
        setupPasswordTextField()
        setupSigninButton()
    }

    private func setupEmailTextField() {
        emailTextField.placeholder = "Enter email address"
        emailTextField.autocapitalizationType = .none
        emailTextField.font = .systemFont(ofSize: 24)

        view.addSubview(emailTextField)

        emailTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.left.right.equalToSuperview().inset(40)
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

    private func setupSigninButton() {
        signinButton.setTitle("Sign in", for: .normal)
        signinButton.backgroundColor = .blue

        view.addSubview(signinButton)

        signinButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.right.equalTo(passwordTextField)
            make.bottom.lessThanOrEqualToSuperview().inset(20)
        }
    }
}

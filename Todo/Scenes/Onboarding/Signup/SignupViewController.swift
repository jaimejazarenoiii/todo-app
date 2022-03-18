//
//  SignupViewController.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import UIKit
import ReSwift
import RxCocoa
import RxSwift

class SignupViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AuthState

    lazy var nameTextField: UITextField = UITextField()
    lazy var emailTextField: UITextField = UITextField()
    lazy var passwordTextField: UITextField = UITextField()
    lazy var confirmPasswordTextField: UITextField = UITextField()
    lazy var signupButton: UIButton = UIButton()
    private let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupScene()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) { $0.select({ $0.authState }) }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }

    func newState(state: AuthState) {
        guard let error = state.authError as? AuthService.AuthError else { return }
        show(error: error)
    }

    private func setupBindings() {
        let nameTextFieldValidation = nameTextField.rx.text.orEmpty.map { $0.count >= 4 }.share(replay: 1)
        let emailTextFieldValidation = emailTextField.rx.text.orEmpty.map { !$0.isEmpty }.share(replay: 1)
        let passwordTextFieldValidation = passwordTextField.rx.text.orEmpty.map { $0.count >= 6 }.share(replay: 1)
        let passwordConfirmationTextFieldValidation = confirmPasswordTextField.rx.text.orEmpty
            .map { [unowned self] confirmPassword in
                confirmPassword.count >= 6 && confirmPassword == self.passwordTextField.text
        }.share(replay: 1)

        let isEnabled = Observable
            .combineLatest(emailTextFieldValidation,
                           passwordTextFieldValidation,
                           passwordConfirmationTextFieldValidation,
                           nameTextFieldValidation) { $0 && $1 && $2 && $3 }
           .share(replay: 1)

        isEnabled
            .bind(to: signupButton.rx.isEnabled).disposed(by: disposeBag)

        isEnabled
            .map { $0 ? UIColor.blue : UIColor.blue.withAlphaComponent(0.5) }
            .bind(to: signupButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        signupButton.rx.tap.bind { [unowned self] _ in
            store.dispatch(AuthAction.signup(name: self.nameTextField.text!,
                                             email: self.emailTextField.text!,
                                             password: self.passwordTextField.text!))
        }.disposed(by: disposeBag)
    }

    private func show(error: AuthService.AuthError) {
        let alert = UIAlertController(title: "Error",
                                      message: error.message,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))

        present(alert, animated: true, completion: nil)
    }
}



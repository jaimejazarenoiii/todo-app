//
//  SigninViewController.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import UIKit
import ReSwift
import RxCocoa
import RxSwift

class SigninViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = AuthState

    lazy var emailTextField: UITextField = UITextField()
    lazy var passwordTextField: UITextField = UITextField()
    lazy var signinButton: UIButton = UIButton()
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

    private func show(error: AuthService.AuthError) {
        let alert = UIAlertController(title: "Error",
                                      message: error.message,
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in 
            store.dispatch(AuthAction.clearError)
        }))

        present(alert, animated: true, completion: nil)
    }

    private func setupBindings() {
        let emailTextFieldValidation = emailTextField.rx.text.orEmpty.map { !$0.isEmpty }.share(replay: 1)
        let passwordTextFieldValidation = passwordTextField.rx.text.orEmpty.map { $0.count >= 6 }.share(replay: 1)

        let isEnabled = Observable.combineLatest(emailTextFieldValidation,
                                                 passwordTextFieldValidation) { $0 && $1 }
            .share(replay: 1)
        isEnabled
            .bind(to: signinButton.rx.isEnabled).disposed(by: disposeBag)

        isEnabled
            .map { $0 ? UIColor.blue : UIColor.blue.withAlphaComponent(0.5) }
            .bind(to: signinButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        signinButton.rx.tap.bind { [unowned self] _ in
            store.dispatch(AuthAction.signin(email: self.emailTextField.text!,
                                             password: self.passwordTextField.text!))
        }.disposed(by: disposeBag)
    }
}

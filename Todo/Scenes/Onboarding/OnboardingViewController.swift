//
//  OnboardingViewController.swift
//  Todo
//
//  Created by Jaime C. Jazareno III on 3/17/22.
//

import UIKit
import SnapKit
import ReSwift
import RxCocoa
import RxSwift

protocol OnboardingViewControllerDelegate: AnyObject {
    func didTapSignin(source: OnboardingViewController)
    func didTapSignup(source: OnboardingViewController)
    func didReauthenticate(source: OnboardingViewController)
}

class OnboardingViewController: UIViewController {
    lazy var textLabel: UILabel = UILabel()
    lazy var signinButton: UIButton = UIButton()
    lazy var signupButton: UIButton = UIButton()
    weak var delegate: OnboardingViewControllerDelegate?
    private let disposeBag: DisposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        setupScene()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        signinButton.rx.tap.bind { [unowned self] _ in
            self.delegate?.didTapSignin(source: self)
        }.disposed(by: disposeBag)

        signupButton.rx.tap.bind { [unowned self] _ in
            self.delegate?.didTapSignup(source: self)
        }.disposed(by: disposeBag)
    }
}



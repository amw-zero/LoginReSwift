//
//  ViewController.swift
//  LoginReSwift
//
//  Created by Alex Weisberger on 12/11/18.
//  Copyright © 2018 vts. All rights reserved.
//

import UIKit
import ReSwift

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        emailTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self) {
            $0.select { $0.loginState }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.unsubscribe(self)
    }
    @objc func textChanged(_ textField: UITextField) {
        store.dispatch(
            LoginAction.credentialsChanged(
                username: text(from: emailTextField),
                password: text(from: passwordTextField)))
    }
    func text(from textField: UITextField) -> String {
        return textField.text ?? ""
    }
}

extension ViewController: StoreSubscriber {
    func newState(state: LoginState) {
        switch state.authenticationScheme {
        case let .password(areCredentialsValid):
            renderLoginButton(areCredentialsValid: areCredentialsValid)
        case .sso:
            renderLoginButton(areCredentialsValid: true)
        }
    }
    func renderLoginButton(areCredentialsValid valid: Bool) {
        loginButton.isEnabled = valid
        let color: UIColor = valid ? .blue : .lightGray
        loginButton.setTitleColor(color, for: .normal)
    }
}


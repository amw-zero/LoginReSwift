//
//  Login.swift
//  LoginReSwift
//
//  Created by Alex Weisberger on 12/11/18.
//  Copyright © 2018 vts. All rights reserved.
//

import Foundation
import ReSwift

enum LoginAction: Action {
    case noop
    case credentialsChanged(username: String, password: String)
}

enum AuthenticationScheme: Equatable {
    case password(areCredentialsValid: Bool)
    case sso
}

struct LoginState: Equatable {
    var authenticationScheme: AuthenticationScheme
    init(authenticationScheme: AuthenticationScheme = .password(areCredentialsValid: false)) {
        self.authenticationScheme = authenticationScheme
    }
}

struct LoginReducer {
    static func reducer(action: LoginAction, state: LoginState?) -> LoginState {
        guard var state = state else {
            return LoginState()
        }
        switch action {
        case let .credentialsChanged(username, password):
            let validCredentials = !username.isEmpty && !password.isEmpty
            state.authenticationScheme = .password(areCredentialsValid: validCredentials)
            return state
        default:
            return state
        }
    }
}

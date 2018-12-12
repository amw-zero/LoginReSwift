//
//  LoginTests.swift
//  LoginReSwiftTests
//
//  Created by Alex Weisberger on 12/11/18.
//  Copyright © 2018 vts. All rights reserved.
//

import XCTest
@testable import LoginReSwift

class LoginTests: XCTestCase {
    var loginState: LoginState!
    override func setUp() {
        loginState = LoginState()
    }
    func testWhenEmailAndPasswordAreNotInput() {
        let action = LoginAction.credentialsChanged(username: "test", password: "")
        let state = LoginReducer.reducer(action: action, state: loginState)
        XCTAssertEqual(state, LoginState(authenticationScheme: .password(areCredentialsValid: false)))
    }
    func testWhenEmailAndPasswordAreInput() {
        let action = LoginAction.credentialsChanged(username: "user@email.com", password: "T")
        let state = LoginReducer.reducer(action: action, state: loginState)
        let expectedAuthScheme = AuthenticationScheme.password(areCredentialsValid: true)
        XCTAssertEqual(state, LoginState(authenticationScheme: expectedAuthScheme))
    }
}

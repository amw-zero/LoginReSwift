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
    func testWhenEmailAndPasswordAreNotInput() {
    }
    func testWhenEmailAndPasswordAreInput() {
        let state = LoginState()
        let action = LoginAction.credentialsChanged(username: "user@email.com", password: "T")
        let newState = LoginReducer.reducer(action: action, state: state)
        let expectedAuthScheme = AuthenticationScheme.password(areCredentialsValid: true)
        XCTAssertEqual(newState, LoginState(authenticationScheme: expectedAuthScheme))
    }
}

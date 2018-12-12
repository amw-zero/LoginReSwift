//
//  Store
//  LoginReSwift
//
//  Created by Alex Weisberger on 12/11/18.
//  Copyright © 2018 vts. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    let loginState: LoginState
    init(loginState: LoginState = LoginState()) {
        self.loginState = loginState
    }
}

func appReducer(action: Action, state: AppState?) -> AppState {
    let state = state ?? AppState()
    return AppState(
        loginState: LoginReducer.reducer(
            action: action as? LoginAction ?? .noop,
            state: state.loginState))
}

let store = Store(reducer: appReducer, state: AppState())

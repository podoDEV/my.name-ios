//
//  LoginViewReactor.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import FBSDKLoginKit
import ReactorKit
import RxCocoa
import RxSwift

final class LoginViewReactor: Reactor {
  enum Action {
    case facebook
  }

  enum Mutation {
    case setLoggedIn(Bool)
  }

  struct State {
    var isLoggedIn: Bool = false
  }

  let initialState = State()

  private let authService: AuthServiceType

  init(
    authService: AuthServiceType
    ) {
    self.authService = authService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .facebook:
      let setLoggedIn: Observable<Mutation> = FBSDKLoginManager().rx.login()
        .map { AccessToken(id: $0) }
        .flatMap { self.authService.authorize($0) }
        .map { true }
        .catchErrorJustReturn(false)
        .map(Mutation.setLoggedIn)
      return setLoggedIn
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let .setLoggedIn(isLoggedIn):
      state.isLoggedIn = isLoggedIn
      return state
    }
  }
}

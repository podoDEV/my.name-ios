//
//  LoginViewReactor.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import FBSDKLoginKit
import GoogleSignIn
import ReactorKit
import RxCocoa
import RxSwift

final class LoginViewReactor: Reactor {
  enum Action {
    case myname(Account)
    case google
    case facebook
  }

  enum Mutation {
    case setLoading(Bool)
    case setLoggedIn(Bool)
  }

  struct State {
    var isLoading: Bool = false
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
    case .myname(let _):
      guard !currentState.isLoading else { return .empty() }
        let startLoading = Observable<Mutation>.just(.setLoading(true))
        let endLoading = Observable<Mutation>.just(.setLoading(false))
      return .concat([startLoading, endLoading])

    case .google:
      guard !currentState.isLoading else { return .empty() }
      let setLoggedIn: Observable<Mutation> = GIDSignIn.sharedInstance().rx.signIn
        .map { AccessToken(id: $0.authentication.accessToken) }
        .flatMap { self.authService.authorize($0) }
        .map { true }
        .catchErrorJustReturn(false)
        .map(Mutation.setLoggedIn)
      return setLoggedIn

    case .facebook:
      guard !currentState.isLoading else { return .empty() }
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
    case let .setLoading(isLoading):
      state.isLoading = isLoading
      return state

    case let .setLoggedIn(isLoggedIn):
      state.isLoggedIn = isLoggedIn
      return state
    }
  }
}

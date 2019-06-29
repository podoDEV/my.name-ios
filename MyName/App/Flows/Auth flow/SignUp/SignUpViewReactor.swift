//
//  SignUpViewReactor.swift
//  MyName
//
//  Created by hb1love on 30/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import ReactorKit
import RxCocoa
import RxSwift

final class SignUpViewReactor: Reactor {
  enum Action {
    case facebook
    case google
  }

  enum Mutation {
    case setLoading(Bool)
  }

  struct State {
    var isLoading: Bool = false
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
      guard !currentState.isLoading else { return .empty() }
      return .empty()

    case .google:
      guard !currentState.isLoading else { return .empty() }
      return .empty()
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case let .setLoading(isLoading):
      state.isLoading = isLoading
      return state
    }
  }
}

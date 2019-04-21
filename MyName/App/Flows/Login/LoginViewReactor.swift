//
//  LoginViewReactor.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class LoginViewReactor: Reactor {
  enum Action {
    case id
  }

  enum Mutation {
    case asd
  }

  struct State {
    var page: Int?
  }

  let initialState = State()
  private let authService: AuthServiceType

  init(
    authService: AuthServiceType
    ) {
    self.authService = authService
  }
}

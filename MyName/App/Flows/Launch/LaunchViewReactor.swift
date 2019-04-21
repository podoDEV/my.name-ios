//
//  LaunchViewReactor.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class LaunchViewReactor: Reactor {
  enum Action {
    case checkIfFirst
  }

  enum Mutation {
    case asd
  }

  struct State {
    var isFirst: Bool?
  }

  let initialState = State()

  init() {}
}

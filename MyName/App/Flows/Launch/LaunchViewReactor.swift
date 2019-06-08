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
    case checkLaunchingInfo
  }

  enum Mutation {
    case isAuthorized(Bool)
    case isFirst(Bool)
    case setEndLaunching(Bool)
  }

  struct State {
    var isAuthorized = false
    var isFirst = true
    var endLaunching = false
  }

  let initialState = State()

  private let memberService: MemberServiceType

  init(
    memberService: MemberServiceType
    ) {
    self.memberService = memberService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .checkLaunchingInfo:
      let isAuthorized = self.memberService.me()
        .asObservable()
        .map { true }
        .catchErrorJustReturn(false)
        .map(Mutation.isAuthorized)

      let isFirst: Observable<Mutation> = .just(.isFirst(false))
      let endLaunching: Observable<Mutation> = .just(.setEndLaunching(true))
      return .concat([isAuthorized, isFirst, endLaunching])
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .isAuthorized(let isAuthorized):
      state.isAuthorized = isAuthorized
    case .isFirst(let isFirst):
      state.isFirst = isFirst
    case .setEndLaunching(let end):
      state.endLaunching = end
    }
    return state
  }
}

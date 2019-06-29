//
//  WelcomeViewReactor.swift
//  MyName
//
//  Created by hb1love on 09/06/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class WelcomeViewReactor: Reactor {
  enum Action {
    case refresh
  }

  enum Mutation {
    case setName(String)
  }

  struct State {
    var name: String = ""
  }

  let initialState = State()
//  let calendarViewReactor: SeasonsCalendarViewReactor
  private let memberService: MemberServiceType

  init(
    memberService: MemberServiceType
    ) {
    self.memberService = memberService
  }

  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .refresh:
      return self.memberService.me()
        .asObservable()
        .flatMap { self.memberService.current }
        .map { $0?.name ?? "" }
        .catchErrorJustReturn("")
        .map(Mutation.setName)
    }
  }

  func reduce(state: State, mutation: Mutation) -> State {
    var state = state
    switch mutation {
    case .setName(let name):
      state.name = name
    }
    return state
  }
}

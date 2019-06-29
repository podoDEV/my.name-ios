//
//  ProfileEditViewReactor.swift
//  MyName
//
//  Created by hb1love on 22/06/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class ProfileEditViewReactor: Reactor {
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
  private let memberService: MemberServiceType
  private let myNameService: MyNameServiceType

  init(
    memberService: MemberServiceType,
    myNameService: MyNameServiceType
    ) {
    self.memberService = memberService
    self.myNameService = myNameService
  }
}

//
//  MainViewReactor.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift

final class MainViewReactor: Reactor {
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
//  let calendarViewReactor: SeasonsCalendarViewReactor
  private let noteService: NoteServiceType

  init(
    noteService: NoteServiceType
//    calendarViewReactorFactory: (Date) -> SeasonsCalendarViewReactor
    ) {
    self.noteService = noteService
//    self.calendarViewReactor = calendarViewReactorFactory(Date())
  }
}

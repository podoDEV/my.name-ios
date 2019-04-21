//
//  AnalyticsEvent.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Firebase
import Umbrella

typealias MyNameAnalytics = Umbrella.Analytics<AnalyticsEvent>
let analytics = MyNameAnalytics()

enum AnalyticsEvent {
  case tryLogin
  case login
  case tryLogout
  case logout

  case flowMain
  case viewNote(noteID: Int)
}

extension AnalyticsEvent: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
    case .tryLogin:
      return "try_login"

    case .login:
      switch provider {
      case is FirebaseProvider:
        return Firebase.AnalyticsEventLogin
      default:
        return "login"
      }

    case .tryLogout:
      return "try_logout"

    case .logout:
      return "logout"

    case .flowMain:
      return "flow_main"

    case .viewNote:
      return "view_note"
    }
  }

  func parameters(for provider: ProviderType) -> [String: Any]? {
    switch self {
    case .tryLogin:
      return nil

    case .login:
      return nil

    case .tryLogout:
      return nil

    case .logout:
      return nil

    case .flowMain:
      return nil

    case .viewNote(let noteID):
      return [
        "note_id": noteID
      ]
    }
  }
}

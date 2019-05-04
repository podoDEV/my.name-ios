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
  case login
  case tryLogout
  case logout

  case flowLaunch
  case flowLogin
  case flowSignup
  case flowMain

  case viewNote(noteID: Int)
}

extension AnalyticsEvent: EventType {
  func name(for provider: ProviderType) -> String? {
    switch self {
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

    case .flowLaunch:
      return "flow_launch"

    case .flowLogin:
      return "flow_login"

    case .flowSignup:
      return "flow_signup"

    case .flowMain:
      return "flow_main"

    case .viewNote:
      return "view_note"
    }
  }

  func parameters(for provider: ProviderType) -> [String: Any]? {
    switch self {
    case .login,
         .tryLogout,
         .logout,
         .flowLaunch,
         .flowLogin,
         .flowSignup,
         .flowMain:
      return nil

    case .viewNote(let noteID):
      return [
        "note_id": noteID
      ]
    }
  }
}

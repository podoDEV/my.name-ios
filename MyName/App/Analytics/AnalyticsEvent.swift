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

  case launchFlow
  case launchView

  case authFlow
  case loginView
  case signUpView

  case mainFlow
  case welcomeView
  case profileDetailView
  case profileEditView
  case settingsView

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
    case .tryLogout: return "try_logout"
    case .logout: return "logout"

    case .launchFlow: return "launch_flow"
    case .launchView: return "launch_view"

    case .authFlow: return "auth_flow"
    case .loginView: return "login_view"
    case .signUpView: return "signup_view"

    case .mainFlow: return "main_flow"
    case .welcomeView: return "welcome_view"
    case .profileDetailView: return "profile_detail_view"
    case .profileEditView: return "profile_edit_view"
    case .settingsView: return "settings_view"

    case .viewNote:return "view_note"
    }
  }

  func parameters(for provider: ProviderType) -> [String: Any]? {
    switch self {
    case .viewNote(let noteID):
      return [
        "note_id": noteID
      ]
    default:
      return nil
    }
  }
}

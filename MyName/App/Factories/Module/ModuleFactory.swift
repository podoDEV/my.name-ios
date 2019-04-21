//
//  ModuleFactory.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

final class ModuleFactory:
  LaunchModuleFactoryType,
  LoginModuleFactoryType,
  OnboardingModuleFactoryType,
  MainModuleFactoryType,
  SettingsModuleFactoryType {

  func makeLaunchModule() -> LaunchViewController {
    let launchViewReactor = LaunchViewReactor()
    return LaunchViewController(reactor: launchViewReactor)
  }

  func makeLoginModule() -> LoginViewController {
    let loginViewReactor = LoginViewReactor(
      authService: container.resolve(AuthService.self)!
    )
    return LoginViewController(reactor: loginViewReactor)
  }

  func makeOnboardingModule() -> OnboardingViewController {
    let onboardingViewReactor = OnboardingViewReactor()
    return OnboardingViewController(reactor: onboardingViewReactor)
  }

  func makeMainModule() -> MainViewController {
    let mainViewReactor = MainViewReactor(
        noteService: NoteService()
    )
//    let mainViewReactor = MainViewReactor(
//      noteService: NoteService(),
//      calendarViewReactorFactory: SeasonsCalendarViewReactor.init
//    )
    return MainViewController(reactor: mainViewReactor)
  }

  func makeSettingsModule() -> SettingsViewController {
    let settingsViewReactor = SettingsViewReactor()
    return SettingsViewController(reactor: settingsViewReactor)
  }
}

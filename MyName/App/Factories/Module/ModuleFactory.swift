//
//  ModuleFactory.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

final class ModuleFactory
  : LaunchModuleFactoryType
  , AuthModuleFactoryType
  , OnboardingModuleFactoryType
  , MainModuleFactoryType
  , EditModuleFactoryType
  , SettingsModuleFactoryType {

  func makeLaunchModule() -> LaunchViewController {
    return LaunchViewController(
      reactor: LaunchViewReactor(
        memberService: container.resolve(MemberService.self)!
      )
    )
  }

  func makeLoginModule() -> LoginViewController {
    return LoginViewController(
      reactor: LoginViewReactor(
        authService: container.resolve(AuthService.self)!,
        memberService: container.resolve(MemberService.self)!
      )
    )
  }

  func makeSignUpModule() -> SignUpViewController {
    return SignUpViewController(
      reactor: SignUpViewReactor(
        authService: container.resolve(AuthService.self)!
      )
    )
  }

  func makeOnboardingModule() -> OnboardingViewController {
    return OnboardingViewController.controllerFromStoryboard("Onboarding")
  }

  func makeWelcomeModule() -> WelcomeViewController {
//    let mainViewReactor = MainViewReactor(
//      noteService: NoteService(),
//      calendarViewReactorFactory: SeasonsCalendarViewReactor.init
//    )
    return WelcomeViewController(
      reactor: WelcomeViewReactor(
        memberService: container.resolve(MemberService.self)!
      )
    )
  }

  func makeProfileDetailModule() -> ProfileDetailViewController {
    return ProfileDetailViewController(
      reactor: ProfileDetailViewReactor(
        memberService: container.resolve(MemberService.self)!,
        myNameService: container.resolve(MyNameService.self)!
      )
    )
  }

  func makeProfileEditModule() -> ProfileEditViewController {
    return ProfileEditViewController(
      reactor: ProfileEditViewReactor(
        memberService: container.resolve(MemberService.self)!,
        myNameService: container.resolve(MyNameService.self)!
      )
    )
  }

  func makeSettingsModule() -> SettingsViewController {
    return SettingsViewController(
      reactor: SettingsViewReactor()
    )
  }
}

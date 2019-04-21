//
//  CoordinatorFactory.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

final class CoordinatorFactory: CoordinatorFactoryType {
  func makeLaunchCoordinator(router: Routable) ->
    Coordinator & LaunchCoordinatorOutput {
      return LaunchCoordinator(
        with: container.resolve(ModuleFactory.self)!,
        router: router
      )
  }

  func makeLoginCoordinator(router: Routable) ->
    Coordinator & LoginCoordinatorOutput {
      return LoginCoordinator(
        with: container.resolve(ModuleFactory.self)!,
        router: router
      )
  }

  func makeOnboardingCoordinator(router: Routable) ->
    Coordinator & OnboardingCoordinatorOutput {
      return OnboardingCoordinator(
        with: container.resolve(ModuleFactory.self)!,
        router: router
      )
  }

  func makeMainCoordinator(router: Routable) ->
    Coordinator & MainCoordinatorOutput {
      return MainCoordinator(
        with: container.resolve(ModuleFactory.self)!,
        router: router
      )
  }
}

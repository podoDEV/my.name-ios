//
//  CoordinatorFactory.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class CoordinatorFactory: CoordinatorFactoryType {

  func makeLaunchCoordinator(router: Routable) ->
    Coordinator & LaunchCoordinatorOutput {
      return LaunchCoordinator(
        coordinatorFactory: container.resolve(CoordinatorFactory.self)!,
        moduleFactory: container.resolve(ModuleFactory.self)!,
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
        coordinatorFactory: container.resolve(CoordinatorFactory.self)!,
        moduleFactory: container.resolve(ModuleFactory.self)!,
        router: router
      )
  }

  func makeSettingsCoordinatorBox() -> (
    coordinator: Coordinator & SettingsCoordinatorOutput,
    router: Routable
    ) {
      return makeSettingsCoordinatorBox(nil)
  }

  func makeSettingsCoordinatorBox(
    _ navController: UINavigationController? = nil
    ) -> (
    coordinator: Coordinator & SettingsCoordinatorOutput,
    router: Routable
    ) {
      let router = self.router(navController)
      let coordinator = SettingsCoordinator(
        with: container.resolve(ModuleFactory.self)!,
        router: router
      )
      return (coordinator, router)
  }

  private func router(_ navController: UINavigationController?) -> Routable {
    return Router(rootController: navController ?? UINavigationController())
  }
}

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
        with: container.resolve(ModuleFactory.self)!,
        router: router
      )
  }

  func makeAuthCoordinator(router: Routable) ->
    Coordinator & AuthCoordinatorOutput {
      return AuthCoordinator(
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

  func makeEditCoordinatorBox() -> (
    coordinator: Coordinator & EditCoordinatorOutput,
    router: Routable
    ) {
      return makeEditCoordinatorBox(nil)
  }

  func makeEditCoordinatorBox(
    _ navController: UINavigationController? = nil
    ) -> (
    coordinator: Coordinator & EditCoordinatorOutput,
    router: Routable
    ) {
      let router = self.router(navController)
      let coordinator = EditCoordinator(
        with: container.resolve(ModuleFactory.self)!,
        router: router
      )
      return (coordinator, router)
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

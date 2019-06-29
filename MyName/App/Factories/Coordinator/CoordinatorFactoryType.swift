//
//  CoordinatorFactoryType.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

protocol CoordinatorFactoryType {

  func makeLaunchCoordinator(router: Routable) ->
    Coordinator & LaunchCoordinatorOutput

  func makeAuthCoordinator(router: Routable) ->
    Coordinator & AuthCoordinatorOutput

  func makeOnboardingCoordinator(router: Routable) ->
    Coordinator & OnboardingCoordinatorOutput

  func makeMainCoordinator(router: Routable) ->
    Coordinator & MainCoordinatorOutput

  func makeEditCoordinatorBox() -> (
    coordinator: Coordinator & EditCoordinatorOutput,
    router: Routable
  )
  func makeEditCoordinatorBox(_ navController: UINavigationController?) -> (
    coordinator: Coordinator & EditCoordinatorOutput,
    router: Routable
  )

  func makeSettingsCoordinatorBox() -> (
    coordinator: Coordinator & SettingsCoordinatorOutput,
    router: Routable
  )
  func makeSettingsCoordinatorBox(_ navController: UINavigationController?) -> (
    coordinator: Coordinator & SettingsCoordinatorOutput,
    router: Routable
  )
}

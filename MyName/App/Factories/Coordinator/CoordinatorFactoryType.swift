//
//  CoordinatorFactoryType.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol CoordinatorFactoryType {

  func makeLaunchCoordinator(router: Routable) ->
    Coordinator & LaunchCoordinatorOutput

  func makeOnboardingCoordinator(router: Routable) ->
    Coordinator & OnboardingCoordinatorOutput

  func makeMainCoordinator(router: Routable) ->
    Coordinator & MainCoordinatorOutput
}

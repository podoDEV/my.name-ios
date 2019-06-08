//
//  ApplicationCoordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

var isLaunched = false
var isAuthorized = false
var onboardingWasShown = true

enum LaunchInstructor {
  case launch, auth, onboarding, main

  static func configure(
    isLaunched: Bool = isLaunched,
    isAuthorized: Bool = isAuthorized,
    tutorialWasShown: Bool = onboardingWasShown
    ) -> LaunchInstructor {
    switch (isLaunched, isAuthorized, tutorialWasShown) {
    case (false, _, _): return .launch
    case (true, false, _): return .auth
    case (true, true, false): return .onboarding
    case (true, true, true): return .main
    }
  }
}

final class ApplicationCoordinator: BaseCoordinator {

  private let coordinatorFactory: CoordinatorFactoryType
  private let router: Routable

  private var instructor: LaunchInstructor {
    return LaunchInstructor.configure()
  }

  init(
    coordinatorFactory: CoordinatorFactoryType,
    router: Routable
    ) {
    self.coordinatorFactory = coordinatorFactory
    self.router = router
  }

  override func start() {
    switch instructor {
    case .launch: runLaunchFlow()
    case .auth: runLoginFlow()
    case .onboarding: runOnboardingFlow()
    case .main: runMainFlow()
    }
  }

  private func runLaunchFlow() {
    let coordinator = coordinatorFactory.makeLaunchCoordinator(router: router)
    coordinator.finishFlow = { [weak self, weak coordinator] authorized, isFirst in
      isLaunched = true
      isAuthorized = authorized
      onboardingWasShown = !isFirst
      self?.start()
      self?.removeDependency(coordinator)
    }
    addDependency(coordinator)
    coordinator.start()
  }

  private func runLoginFlow() {
    let coordinator = coordinatorFactory.makeAuthCoordinator(router: router)
    coordinator.finishFlow = { [weak self, weak coordinator] in
      isAuthorized = true
      self?.start()
      self?.removeDependency(coordinator)
    }
    addDependency(coordinator)
    coordinator.start()
  }

  private func runOnboardingFlow() {
    let coordinator = coordinatorFactory.makeOnboardingCoordinator(router: router)
    coordinator.finishFlow = { [weak self, weak coordinator] in
      onboardingWasShown = true
      self?.start()
      self?.removeDependency(coordinator)
    }
    addDependency(coordinator)
    coordinator.start()
  }

  private func runMainFlow() {
    let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
    coordinator.finishFlow = { [weak self, weak coordinator] in
      self?.start()
      self?.removeDependency(coordinator)
    }
    addDependency(coordinator)
    coordinator.start()
  }
}

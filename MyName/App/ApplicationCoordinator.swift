//
//  ApplicationCoordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

var isLaunched = true
var isAutorized = true
var onboardingWasShown = true

enum LaunchInstructor {
  case launch, auth, onboarding, main

  static func configure(
    isLaunched: Bool = isLaunched,
    isAutorized: Bool = isAutorized,
    tutorialWasShown: Bool = onboardingWasShown
    ) -> LaunchInstructor {
    switch (isLaunched, isAutorized, tutorialWasShown) {
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
    coordinator.finishFlow = { [weak self, weak coordinator] in
      isLaunched = true
      self?.start()
      self?.removeDependency(coordinator)
    }
    addDependency(coordinator)
    coordinator.start()
  }

  private func runLoginFlow() {
    let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
    coordinator.finishFlow = { [weak self, weak coordinator] in
      isAutorized = true
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

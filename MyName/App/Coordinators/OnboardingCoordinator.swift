//
//  OnboardingCoordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol OnboardingCoordinatorOutput: AnyObject {
  var finishFlow: (() -> Void)? { get set }
}

final class OnboardingCoordinator: BaseCoordinator, OnboardingCoordinatorOutput {

  var finishFlow: (() -> Void)?

  private let factory: OnboardingModuleFactoryType
  private let router: Routable

  init(
    with factory: OnboardingModuleFactoryType,
    router: Routable
    ) {
    self.factory = factory
    self.router = router
  }

  override func start() {
    showOnboarding()
  }

  func showOnboarding() {
    let onboardingModule = factory.makeOnboardingModule()
    onboardingModule.onFinish = { [weak self] in
      self?.finishFlow?()
    }
    router.setRoot(onboardingModule)
  }
}

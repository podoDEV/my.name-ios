//
//  LaunchCoordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol LaunchCoordinatorOutput: AnyObject {
  var finishFlow: (() -> Void)? { get set }
}

final class LaunchCoordinator: BaseCoordinator, LaunchCoordinatorOutput {

  var finishFlow: (() -> Void)?

//  private var instructor: LaunchInstructor {
//    return LaunchInstructor.configure()
//  }
  private let coordinatorFactory: CoordinatorFactoryType
  private let moduleFactory: LaunchModuleFactoryType
  private let router: Routable

  init(
    coordinatorFactory: CoordinatorFactoryType,
    moduleFactory: LaunchModuleFactoryType,
    router: Routable
    ) {
    self.coordinatorFactory = coordinatorFactory
    self.moduleFactory = moduleFactory
    self.router = router
  }

  override func start() {
    showLaunch()
  }

  func showLaunch() {
    let launchModule = moduleFactory.makeLaunchModule()
    launchModule.onFinish = { [weak self] in
      self?.finishFlow?()
    }
    router.setRoot(launchModule)
  }
}

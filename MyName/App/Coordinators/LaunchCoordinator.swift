//
//  LaunchCoordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol LaunchCoordinatorOutput: AnyObject {
  var finishFlow: ((_ isAuthorized: Bool, _ isFirst: Bool) -> Void)? { get set }
}

final class LaunchCoordinator: BaseCoordinator, LaunchCoordinatorOutput {

  var finishFlow: ((_ isAuthorized: Bool, _ isFirst: Bool) -> Void)?

  private let moduleFactory: LaunchModuleFactoryType
  private let router: Routable

  init(
    with factory: LaunchModuleFactoryType,
    router: Routable
    ) {
    self.moduleFactory = factory
    self.router = router
  }

  override func start() {
    showLaunch()
  }

  func showLaunch() {
    let launchModule = moduleFactory.makeLaunchModule()
    launchModule.onFinish = { [weak self] isAuthorized, isFirst in
      self?.finishFlow?(isAuthorized, isFirst)
    }
    router.setRoot(launchModule)
  }
}

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

  private let factory: LaunchModuleFactoryType
  private let router: Routable

  init(
    with factory: LaunchModuleFactoryType,
    router: Routable
    ) {
    self.factory = factory
    self.router = router
  }

  override func start() {
    showLaunch()
  }

  func showLaunch() {
    let launchModule = factory.makeLaunchModule()
    router.setRoot(launchModule)
  }
}

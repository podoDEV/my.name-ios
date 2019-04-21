//
//  SettingsCoordinator.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol SettingsCoordinatorOutput: AnyObject {
  var finishFlow: (() -> Void)? { get set }
}

final class SettingsCoordinator: BaseCoordinator, SettingsCoordinatorOutput {

  var finishFlow: (() -> Void)?

  private let factory: SettingsModuleFactoryType
  private let router: Routable

  init(
    with factory: SettingsModuleFactoryType,
    router: Routable
    ) {
    self.factory = factory
    self.router = router
  }

  override func start() {
    showSettings()
  }

  func showSettings() {
    let settingsModule = factory.makeSettingsModule()
    settingsModule.onFinish = { [weak self] in
      self?.finishFlow?()
    }
    router.setRoot(settingsModule)
    log.debug("setRoot settings")
  }
}

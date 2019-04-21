//
//  MainCoordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol MainCoordinatorOutput: AnyObject {
  var finishFlow: (() -> Void)? { get set }
}

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {

  var finishFlow: (() -> Void)?
  private let coordinatorFactory: CoordinatorFactoryType
  private let moduleFactory: MainModuleFactoryType
  private let router: Routable

  init(
    coordinatorFactory: CoordinatorFactoryType,
    moduleFactory: MainModuleFactoryType,
    router: Routable
    ) {
    self.coordinatorFactory = coordinatorFactory
    self.moduleFactory = moduleFactory
    self.router = router
  }

  override func start() {
    showMain()
  }

  private func showMain() {
    let mainModule = moduleFactory.makeMainModule()
    mainModule.onSelectSettings = { [weak self] in
      self?.runSettingsFlow()
    }
    router.setRoot(mainModule)
  }

  private func runSettingsFlow() {
    let (coordinator, module) = coordinatorFactory.makeSettingsCoordinatorBox()
    coordinator.finishFlow = { [weak self, weak coordinator] in
      self?.router.dismiss()
      self?.removeDependency(coordinator)
    }
    addDependency(coordinator)
    router.present(module)
    coordinator.start()
  }
}

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

  private let factory: MainModuleFactoryType
  private let router: Routable

  init(
    with factory: MainModuleFactoryType,
    router: Routable
    ) {
    self.factory = factory
    self.router = router
  }

  override func start() {
    showMain()
  }

  private func showMain() {
    let mainModule = factory.makeMainModule()
    router.setRoot(mainModule.present())
  }
}

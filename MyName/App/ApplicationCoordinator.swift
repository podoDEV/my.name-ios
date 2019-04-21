//
//  ApplicationCoordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

final class ApplicationCoordinator: BaseCoordinator {

  private let coordinatorFactory: CoordinatorFactoryType
  private let router: Routable

  init(
    coordinatorFactory: CoordinatorFactoryType,
    router: Routable
    ) {
    self.coordinatorFactory = coordinatorFactory
    self.router = router
  }

  override func start() {
    runLaunchFlow()
  }

  func runLaunchFlow() {
//    let coordinator = coordinatorFactory.makeLaunchCoordinator(router: router)
    let coordinator = coordinatorFactory.makeMainCoordinator(router: router)
//    coordinator.finishFlow {
//      self.
//    }
    addDependency(coordinator)
    coordinator.start()
  }
}

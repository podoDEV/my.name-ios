//
//  BaseCoordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

class BaseCoordinator: Coordinator {

  var childCoordinators: [Coordinator] = []

  func start() {}

  func addDependency(_ coordinator: Coordinator) {
    guard childCoordinators.contains(where: { $0 === coordinator }) == false else { return }
    childCoordinators.append(coordinator)
  }

  func removeDependency(_ coordinator: Coordinator?) {
    if childCoordinators.isEmpty { return }
    guard let coordinator = coordinator else { return }

    // Clear child-coordinators recursively
    if let coordinator = coordinator as? BaseCoordinator,
      coordinator.childCoordinators.isEmpty == false {
      coordinator.childCoordinators
        .filter { $0 !== coordinator }
        .forEach { coordinator.removeDependency($0) }
    }
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
      childCoordinators.remove(at: index)
      break
    }
  }
}

extension Coordinator {
  func start() {}

  func addDependency(_ coordinator: Coordinator) {
    guard childCoordinators.contains(where: { $0 === coordinator }) == false else { return }
    childCoordinators.append(coordinator)
  }

  func removeDependency(_ coordinator: Coordinator?) {
    if childCoordinators.isEmpty { return }
    guard let coordinator = coordinator else { return }

    // Clear child-coordinators recursively
    if let coordinator = coordinator as? BaseCoordinator,
      coordinator.childCoordinators.isEmpty == false {
      coordinator.childCoordinators
        .filter { $0 !== coordinator }
        .forEach { coordinator.removeDependency($0) }
    }
    for (index, element) in childCoordinators.enumerated() where element === coordinator {
      childCoordinators.remove(at: index)
      break
    }
  }
}

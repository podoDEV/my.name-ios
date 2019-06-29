//
//  EditCoordinator.swift
//  MyName
//
//  Created by NHNEnt on 29/06/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol EditCoordinatorOutput: AnyObject {
  var finishFlow: (() -> Void)? { get set }
}

final class EditCoordinator: BaseCoordinator, EditCoordinatorOutput {

  var finishFlow: (() -> Void)?
  private let moduleFactory: EditModuleFactoryType
  private let router: Routable

  init(
    with factory: EditModuleFactoryType,
    router: Routable
    ) {
    self.moduleFactory = factory
    self.router = router
  }

  override func start() {
    showProfileEdit()
  }

  private func showProfileEdit() {
    let editModule = moduleFactory.makeProfileEditModule()
    editModule.onFinish = {

    }
    router.setRoot(editModule)
  }
}

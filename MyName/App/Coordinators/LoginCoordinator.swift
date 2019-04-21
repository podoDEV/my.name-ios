//
//  LoginCoordinator.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol LoginCoordinatorOutput: AnyObject {
  var finishFlow: (() -> Void)? { get set }
}

final class LoginCoordinator: BaseCoordinator, LoginCoordinatorOutput {

  var finishFlow: (() -> Void)?

  private let factory: LoginModuleFactoryType
  private let router: Routable

  init(
    with factory: LoginModuleFactoryType,
    router: Routable
    ) {
    self.factory = factory
    self.router = router
  }

  override func start() {
    showLogin()
  }

  func showLogin() {
    let loginModule = factory.makeLoginModule()
    router.setRoot(loginModule)
  }
}

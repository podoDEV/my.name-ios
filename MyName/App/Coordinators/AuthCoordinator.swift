//
//  AuthCoordinator.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol AuthCoordinatorOutput: AnyObject {
  var finishFlow: (() -> Void)? { get set }
//  var
}

final class AuthCoordinator: BaseCoordinator, AuthCoordinatorOutput {

  var finishFlow: (() -> Void)?

  private let factory: AuthModuleFactoryType
  private let router: Routable

  init(
    with factory: AuthModuleFactoryType,
    router: Routable
    ) {
    self.factory = factory
    self.router = router
  }

  override func start() {
    showLogin()
  }

  private func showLogin() {
    let loginModule = factory.makeLoginModule()
    loginModule.onFinish = { [weak self] in
      self?.finishFlow?()
    }
    loginModule.onSignUp = { [weak self] in
      self?.showSignUp()
    }
    router.setRoot(loginModule)
  }

  private func showSignUp() {
    let signUpModule = factory.makeSignUpModule()
    signUpModule.onCompleteSignUp = { [weak self] in
      self?.finishFlow?()
    }
//    signUpModule?.onTermsButtonTap = { [weak self] in
//      self?.showTerms()
//    }
    router.setRoot(signUpModule)
  }
}

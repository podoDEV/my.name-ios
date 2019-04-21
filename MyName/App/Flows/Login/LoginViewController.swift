//
//  LoginViewController.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import ReactorKit
import RxSwift
import Scope
import SideMenu
import SnapKit

final class LoginViewController: BaseViewController, ReactorView {

  // MARK: Constants

  // MARK: - Subviews

  // MARK: - Flow handler

  // MARK: - Initialize

  init(
    reactor: LoginViewReactor
    ) {
    super.init()
    self.reactor = reactor
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func setupConstraints() {}
}

// MARK: - Configuring

extension LoginViewController {

  func setupSubviews() {}

  func bindAction(reactor: LoginViewReactor) {}

  func bindState(reactor: LoginViewReactor) {}
}

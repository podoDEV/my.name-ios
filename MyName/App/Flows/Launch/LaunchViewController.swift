//
//  LaunchViewController.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import ReactorKit

final class LaunchViewController: BaseViewController, ReactorView {

  // MARK: Constants

  // MARK: - Subviews

  // MARK: - Flow handler

  // MARK: - Initialize

  init(
    reactor: LaunchViewReactor
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

extension LaunchViewController {

  func setupSubviews() {}

  func bindAction(reactor: LaunchViewReactor) {}

  func bindState(reactor: LaunchViewReactor) {}
}

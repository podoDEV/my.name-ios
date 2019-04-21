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

  private var logoView: UILabel!

  // MARK: - Flow handler

  var onFinish: (() -> Void)?

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

  override func setupConstraints() {
    logoView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: - Configuring

extension LaunchViewController {

  func setupSubviews() {
    
    logoView = UILabel().also {
      $0.text = "런칭"
      $0.font = .preferredFont(type: .calendar)
      view.addSubview($0)
    }
  }

  func bindAction(reactor: LaunchViewReactor) {
    rx.viewWillAppear
      .subscribe(onNext: { _ in
        analytics.log(.flowLaunch)
      }).disposed(by: disposeBag)
  }

  func bindState(reactor: LaunchViewReactor) {}
}

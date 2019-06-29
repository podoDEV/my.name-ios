//
//  SettingsViewController.swift
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

final class SettingsViewController: BaseViewController, ReactorView {

  // MARK: Constants

  // MARK: - Subviews

  private var logoView: UILabel!
  private let item = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)

  // MARK: - Flow handler

  var onFinish: (() -> Void)?

  // MARK: - Initialize

  init(
    reactor: SettingsViewReactor
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

extension SettingsViewController {

  func setupSubviews() {
    navigationItem.leftBarButtonItem = item
    logoView = UILabel().also {
      $0.text = "Settings"
//      $0.font = .preferredFont(type: .calendar)
      view.addSubview($0)
    }
  }

  func bindAction(reactor: SettingsViewReactor) {
    rx.viewWillAppear
      .subscribe(onNext: { _ in
        log.debug("settings viewWillAppear")
      }).disposed(by: disposeBag)

    item.rx.tap
      .asDriver()
      .throttle(0.2)
      .drive(onNext: { [weak self] _ in
        self?.onFinish?()
      }).disposed(by: disposeBag)
  }

  func bindState(reactor: SettingsViewReactor) {}
}

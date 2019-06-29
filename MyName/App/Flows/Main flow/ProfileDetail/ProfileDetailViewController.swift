//
//  ProfileDetailViewController.swift
//  MyName
//
//  Created by hb1love on 22/06/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class ProfileDetailViewController: BaseViewController, ReactorView {

  // MARK: Constants

  // MARK: - Subviews

  private var logoView: UILabel!
  private let item = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)

  // MARK: - Flow handler

  var onFinish: (() -> Void)?

  // MARK: - Initialize

  init(
    reactor: ProfileDetailViewReactor
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

extension ProfileDetailViewController {

  func setupSubviews() {
    navigationItem.leftBarButtonItem = item
    logoView = UILabel().also {
      $0.text = "Settings"
      //      $0.font = .preferredFont(type: .calendar)
      view.addSubview($0)
    }
  }

  func bindAction(reactor: ProfileDetailViewReactor) {
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

  func bindState(reactor: ProfileDetailViewReactor) {}
}

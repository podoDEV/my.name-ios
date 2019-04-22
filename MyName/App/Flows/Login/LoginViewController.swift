//
//  LoginViewController.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift
import Scope
import SideMenu
import SnapKit

final class LoginViewController: BaseViewController, ReactorView {

  // MARK: Constants

  // MARK: - Subviews

  private var facebookButton: UIButton!

  // MARK: - Flow handler

  var onFinish: (() -> Void)?

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

  override func setupConstraints() {
    facebookButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.leading.equalToSuperview().offset(50)
      $0.trailing.equalToSuperview().offset(-50)
      $0.height.equalTo(60)
      $0.bottom.equalToSuperview().offset(-200)
    }
  }
}

// MARK: - Configuring

extension LoginViewController {

  func setupSubviews() {
    facebookButton = UIButton().also {
      $0.backgroundColor = .red
      $0.setTitle("Facebook Login", for: .normal)
      view.addSubview($0)
    }
  }

  func bindAction(reactor: LoginViewReactor) {
    rx.viewWillAppear
      .subscribe(onNext: { [weak self] _ in
        analytics.log(.flowLogin)
        self?.navigationController?.setNavigationBarHidden(true, animated: true)
      }).disposed(by: disposeBag)

    rx.viewWillDisappear
      .subscribe(onNext: { [weak self] _ in
        self?.navigationController?.setNavigationBarHidden(false, animated: true)
      }).disposed(by: disposeBag)

    facebookButton.rx.tap
      .map { Reactor.Action.facebook }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
  }

  func bindState(reactor: LoginViewReactor) {}
}

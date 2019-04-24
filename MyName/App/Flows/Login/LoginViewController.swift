//
//  LoginViewController.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import GoogleSignIn
import ReactorKit
import RxSwift
import Scope
import SideMenu
import SnapKit

final class LoginViewController: BaseViewController, ReactorView {

  // MARK: Constants

  private struct Metric {
    static let leadingTrailing = CGFloat(50)
    static let height = CGFloat(40)
    static let bottom = CGFloat(150)
    static let bottomGap = CGFloat(30)
  }

  // MARK: - Subviews

  private var myNameButton: UIButton!
  private var facebookButton: UIButton!
  private var googleButton: UIButton!

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
    googleButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.height)
      $0.bottom.equalToSuperview().offset(-Metric.bottom)
    }
    facebookButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.height)
      $0.bottom.equalTo(googleButton.snp.top).offset(-Metric.bottomGap)
    }
    myNameButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.height)
      $0.bottom.equalTo(facebookButton.snp.top).offset(-Metric.bottomGap)
    }
  }
}

// MARK: - Configuring

extension LoginViewController {

  func setupSubviews() {
    myNameButton = UIButton().also {
      $0.backgroundColor = .purple
      $0.setTitle("MyName 가입", for: .normal)
      view.addSubview($0)
    }
    facebookButton = UIButton().also {
      $0.backgroundColor = .red
      $0.setTitle("Facebook 으로 가입", for: .normal)
      view.addSubview($0)
    }
    googleButton = UIButton().also {
      $0.backgroundColor = .blue
      $0.setTitle("Google 로 가입", for: .normal)
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

    googleButton.rx.tap
      .map { Reactor.Action.google }
      .subscribe(onNext: { [weak self] in
        reactor.action.onNext($0)
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
      }).disposed(by: disposeBag)
  }

  func bindState(reactor: LoginViewReactor) {
    reactor.state.map { $0.isLoggedIn }
      .distinctUntilChanged()
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        self?.onFinish?()
      })
      .disposed(by: disposeBag)

    reactor.state.map { $0.isLoggedIn }
      .distinctUntilChanged()
      .filter { $0 }
      .subscribe(onNext: { _ in
        analytics.log(.login)
        log.debug("yeah~~")
      })
      .disposed(by: disposeBag)
  }
}

extension LoginViewController: GIDSignInUIDelegate {
  func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
    self.present(viewController, animated: true, completion: nil)
  }

  func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
    self.dismiss(animated: true, completion: nil)
  }
}

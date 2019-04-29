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
    static let logoLeadingTrailing = CGFloat(40)
    static let logoTop = CGFloat(90)
    static let leadingTrailing = CGFloat(50)
    static let fieldHeight = CGFloat(20)
    static let buttonHeight = CGFloat(38)
    static let separatorGap = CGFloat(12)
    static let buttonGap = CGFloat(16)
    static let separatorHeight = CGFloat(1)
  }

  // MARK: - Subviews

  private var logoLabel: UILabel!
  private var emailField: UITextField!
  private var emailSeparatorView: UIView!
  private var passwordField: UITextField!
  private var passwordSeparatorView: UIView!
  private var myNameLoginButton: UIView!
  private var googleButton: UIButton!
  private var facebookButton: UIButton!
  private var myNameSignUpButton: UIButton!

  // MARK: - Properties

  private var logoCenterConstraint: Constraint?
  private var logoTopConstraint: Constraint?

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
    logoLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.logoLeadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.logoLeadingTrailing)
      logoCenterConstraint = $0.centerY.equalToSuperview().constraint
      logoTopConstraint = $0.top.equalToSuperview().offset(Metric.logoTop).constraint
      logoCenterConstraint?.activate()
      logoTopConstraint?.deactivate()
    }
    emailField.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview().offset(30)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.fieldHeight)
    }
    emailSeparatorView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(emailField.snp.bottom).offset(Metric.separatorGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.separatorHeight)
    }
    passwordField.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(emailSeparatorView.snp.bottom).offset(Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.fieldHeight)
    }
    passwordSeparatorView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(passwordField.snp.bottom).offset(Metric.separatorGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.separatorHeight)
    }
    myNameLoginButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(passwordSeparatorView.snp.bottom).offset(Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
    googleButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(myNameLoginButton.snp.bottom).offset(Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
    facebookButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(googleButton.snp.bottom).offset(Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
    myNameSignUpButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(facebookButton.snp.bottom).offset(40)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
  }
}

// MARK: - Configuring

extension LoginViewController {

  func setupSubviews() {
    logoLabel = UILabel().also {
      $0.text = "my\nname\nis ___"
      $0.font = .preferredFont(type: .avantGardeMdITCTTBold, size: 80)
      $0.numberOfLines = 3
      view.addSubview($0)
    }
    emailField = UITextField().also {
      $0.placeholder = "email"
      $0.keyboardType = .emailAddress
      $0.textColor = .textColorBlack3C
      $0.clearButtonMode = .whileEditing
      $0.alpha = 0
      view.addSubview($0)
    }
    emailSeparatorView = UIView().also {
      $0.backgroundColor = .separatorViewColor
      $0.alpha = 0
      view.addSubview($0)
    }
    passwordField = UITextField().also {
      $0.placeholder = "password"
      $0.isSecureTextEntry = true
      $0.textContentType = .password
      $0.textColor = .textColorBlack3C
      $0.clearButtonMode = .whileEditing
      $0.clearsOnBeginEditing = true
      $0.alpha = 0
      view.addSubview($0)
    }
    passwordSeparatorView = UIView().also {
      $0.backgroundColor = .separatorViewColor
      $0.alpha = 0
      view.addSubview($0)
    }
    myNameLoginButton = UIButton().also {
      $0.backgroundColor = .white
      $0.setTitleColor(.loginButtonColor, for: .normal)
      $0.setTitle("Login", for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 17)
      $0.layer.borderColor = UIColor.loginButtonColor.cgColor
      $0.layer.borderWidth = 1
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      view.addSubview($0)
    }
    googleButton = UIButton().also {
      $0.backgroundColor = .white
      $0.setTitle("log in with Google", for: .normal)
      $0.setTitleColor(.gray, for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 17)
      $0.layer.borderColor = UIColor.black3.cgColor
      $0.layer.borderWidth = 1
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      view.addSubview($0)
    }
    facebookButton = UIButton().also {
      $0.backgroundColor = .white
      $0.setTitle("log in with Facebook", for: .normal)
      $0.setTitleColor(.facebookColor, for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 17)
      $0.layer.borderColor = UIColor.facebookColor.cgColor
      $0.layer.borderWidth = 1
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      view.addSubview($0)
    }
    myNameSignUpButton = UIButton().also {
      $0.setTitle("join in", for: .normal)
      $0.setTitleColor(.loginButtonColor, for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 17)
      $0.alpha = 0
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

    rx.viewDidAppear
      .delay(1, scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.animateLoginView()
      }).disposed(by: disposeBag)

    emailField.rx.controlEvent([.editingDidEndOnExit])
      .subscribe(onNext: { [weak self] in
        self?.passwordField.becomeFirstResponder()
      }).disposed(by: disposeBag)

    passwordField.rx.controlEvent([.editingDidEndOnExit])
      .subscribe(onNext: { [weak self] in
        self?.resignFirstResponder()
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

private extension LoginViewController {

  func animateLoginView() {
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
      self.logoCenterConstraint?.deactivate()
      self.logoTopConstraint?.activate()
      self.emailField.alpha = 1
      self.emailSeparatorView.alpha = 1
      self.passwordField.alpha = 1
      self.passwordSeparatorView.alpha = 1
      self.myNameLoginButton.alpha = 1
      self.googleButton.alpha = 1
      self.facebookButton.alpha = 1
      self.myNameSignUpButton.alpha = 1
      self.view.layoutIfNeeded()
    })
  }
}

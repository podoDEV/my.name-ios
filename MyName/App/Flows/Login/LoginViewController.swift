//
//  LoginViewController.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import GoogleSignIn
import NVActivityIndicatorView
import ReactorKit
import RxGesture
import RxSwift
import Scope
import SnapKit

final class LoginViewController: BaseViewController, ReactorView, NVActivityIndicatorViewable {

  // MARK: Constants

  private struct Metric {
    static let logoLeadingTrailing = CGFloat(40)
    static let logoLoadingTop = CGFloat(220)
    static let logoTop = CGFloat(100)
    static let leadingTrailing = CGFloat(60)
    static let emailFieldTop = CGFloat(50)
    static let fieldHeight = CGFloat(20)
    static let buttonHeight = CGFloat(38)
    static let separatorGap = CGFloat(6)
    static let buttonGap = CGFloat(16)
    static let signUpButtonTop = CGFloat(50)
    static let separatorHeight = CGFloat(1)
  }

  // MARK: - Subviews

  private var scrollView: UIScrollView!
  private var contentView: UIView!
  private var logoLabel: UILabel!
  private var emailField: UITextField!
  private var emailSeparatorView: UIView!
  private var passwordField: UITextField!
  private var passwordSeparatorView: UIView!
  private var myNameLoginButton: UIButton!
  private var googleButton: UIButton!
  private var facebookButton: UIButton!
  private var myNameSignUpButton: UIButton!

  // MARK: - Properties

  private var logoTopConstraint: Constraint?
  private var contentHeightConstraint: Constraint?

  // MARK: - Flow handler

  var onFinish: (() -> Void)?
  var onSignUp: (() -> Void)?

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
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    contentView.snp.makeConstraints {
      $0.top.bottom.leading.trailing.width.equalToSuperview()
      contentHeightConstraint = $0.height.equalToSuperview().constraint
      contentHeightConstraint?.activate()
    }
    logoLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.logoLeadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.logoLeadingTrailing)
      logoTopConstraint = $0.top.equalToSuperview().offset(Metric.logoLoadingTop).constraint
      logoTopConstraint?.activate()
    }
    emailField.snp.makeConstraints {
      $0.top.equalTo(logoLabel.snp.bottom).offset(Metric.emailFieldTop)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.fieldHeight)
    }
    emailSeparatorView.snp.makeConstraints {
      $0.top.equalTo(emailField.snp.bottom).offset(Metric.separatorGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.separatorHeight)
    }
    passwordField.snp.makeConstraints {
      $0.top.equalTo(emailSeparatorView.snp.bottom).offset(Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.fieldHeight)
    }
    passwordSeparatorView.snp.makeConstraints {
      $0.top.equalTo(passwordField.snp.bottom).offset(Metric.separatorGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.separatorHeight)
    }
    myNameLoginButton.snp.makeConstraints {
      $0.top.equalTo(passwordSeparatorView.snp.bottom).offset(Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
    googleButton.snp.makeConstraints {
      $0.top.equalTo(myNameLoginButton.snp.bottom).offset(Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
    facebookButton.snp.makeConstraints {
      $0.top.equalTo(googleButton.snp.bottom).offset(Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
    myNameSignUpButton.snp.makeConstraints {
      $0.top.equalTo(facebookButton.snp.bottom).offset(Metric.signUpButtonTop)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
  }
}

// MARK: - Configuring

extension LoginViewController {

  func setupSubviews() {
    scrollView = UIScrollView().also {
      $0.isScrollEnabled = false
      view.addSubview($0)
    }
    contentView = UIView().also {
      scrollView.addSubview($0)
    }
    logoLabel = UILabel().also {
      $0.text = "my\nname\nis ___"
      $0.font = .preferredFont(type: .avantGardeMdITCTTBold, size: 80)
      $0.numberOfLines = 3
      contentView.addSubview($0)
    }
    emailField = UITextField().also {
      $0.placeholder = "email"
      $0.keyboardType = .emailAddress
      $0.textColor = .textColorBlack3C
      $0.clearButtonMode = .whileEditing
      $0.font = .preferredFont(type: .avenirBook, size: 17)
      $0.alpha = 0
      contentView.addSubview($0)
    }
    emailSeparatorView = UIView().also {
      $0.backgroundColor = .separatorViewColor
      $0.alpha = 0
      contentView.addSubview($0)
    }
    passwordField = UITextField().also {
      $0.placeholder = "password"
      $0.isSecureTextEntry = true
      $0.textContentType = .password
      $0.textColor = .textColorBlack3C
      $0.clearButtonMode = .whileEditing
      $0.clearsOnBeginEditing = true
      $0.font = .preferredFont(type: .avenirBook, size: 17)
      $0.alpha = 0
      contentView.addSubview($0)
    }
    passwordSeparatorView = UIView().also {
      $0.backgroundColor = .separatorViewColor
      $0.alpha = 0
      contentView.addSubview($0)
    }
    myNameLoginButton = UIButton().also {
      $0.backgroundColor = .myNameColor
      $0.setTitleColor(.white, for: .normal)
      $0.setTitle("log in", for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 18)
      $0.layer.borderColor = UIColor.myNameColor.cgColor
      $0.layer.borderWidth = 1
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      contentView.addSubview($0)
    }
    googleButton = UIButton().also {
      $0.backgroundColor = .white
      $0.setTitle("log in with Google", for: .normal)
      $0.setTitleColor(.googleColor, for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 18)
      $0.layer.borderColor = UIColor.googleColor.cgColor
      $0.layer.borderWidth = 1
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      contentView.addSubview($0)
    }
    facebookButton = UIButton().also {
      $0.backgroundColor = .facebookColor
      $0.setTitle("log in with Facebook", for: .normal)
      $0.setTitleColor(.white, for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 18)
      $0.layer.borderColor = UIColor.facebookColor.cgColor
      $0.layer.borderWidth = 1
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      contentView.addSubview($0)
    }
    myNameSignUpButton = UIButton().also {
      $0.setTitle("join in", for: .normal)
      $0.setTitleColor(.loginButtonColor, for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 17)
      $0.alpha = 0
      contentView.addSubview($0)
    }
  }

  func bindAction(reactor: LoginViewReactor) {
//    RxKeyboard.instance.willShowVisibleHeight
//      .drive(onNext: { [weak self] keyboardHeight in
//        self?.beginEditing(keyboardHeight: keyboardHeight)
//      })
//      .disposed(by: disposeBag)
    keyboardHeight()
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] keyboardHeight in
        keyboardHeight > 0 ? self?.beginEditing(keyboardHeight: keyboardHeight) : self?.endEditing()
      }).disposed(by: disposeBag)
    
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
        self?.entryLoginView()
      }).disposed(by: disposeBag)

    view.rx
      .tapGesture()
      .when(.recognized)
      .subscribe(onNext: { [weak self] _ in
        self?.view.endEditing(true)
      }).disposed(by: disposeBag)

    emailField.rx.controlEvent([.editingDidEndOnExit])
      .subscribe(onNext: { [weak self] in
        self?.passwordField.becomeFirstResponder()
      }).disposed(by: disposeBag)

    passwordField.rx.controlEvent([.editingDidEndOnExit])
      .subscribe(onNext: { [weak self] in
        self?.view.endEditing(true)
      }).disposed(by: disposeBag)

    Observable
      .combineLatest(emailField.rx.text.orEmpty.map { $0.count >= 2 },
                     passwordField.rx.text.orEmpty.map { $0.count >= 4 })
      .bind { [weak self] emailValidation, passwordValidation in
        let enable = emailValidation && passwordValidation
        self?.myNameLoginButton.let {
          $0.isUserInteractionEnabled = enable
          $0.backgroundColor = enable ? .myNameColor : .white
          $0.setTitleColor(enable ? .white : .myNameColor, for: .normal)
        }
      }.disposed(by: disposeBag)

    myNameLoginButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.view.endEditing(true)
        guard let email = self?.emailField.text else { return }
        guard let password = self?.passwordField.text else { return }
        let account = Account(email: email, password: password)
        reactor.action.onNext(.myname(account))
      }).disposed(by: disposeBag)

    googleButton.rx.tap
      .map { Reactor.Action.google }
      .subscribe(onNext: { [weak self] in
        reactor.action.onNext($0)
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
      }).disposed(by: disposeBag)

    facebookButton.rx.tap
      .map { Reactor.Action.facebook }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    myNameSignUpButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.view.endEditing(true)
        self?.onSignUp?()
      }).disposed(by: disposeBag)
  }

  func bindState(reactor: LoginViewReactor) {
    reactor.state.map { $0.isLoading }
      .distinctUntilChanged()
      .subscribe(onNext: { [weak self] isLoading in
        isLoading ? self?.startAnimating(CGSize(width: 30, height: 30))
          : self?.stopAnimating()
      })
      .disposed(by: disposeBag)

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

// MARK: - Delegate

extension LoginViewController: GIDSignInUIDelegate {
  func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
    self.present(viewController, animated: true, completion: nil)
  }

  func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
    self.dismiss(animated: true, completion: nil)
  }
}

// MARK: - Animation

private extension LoginViewController {

  func entryLoginView() {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.scrollView.contentOffset.y = 0
      self.logoLabel.snp.updateConstraints {
        self.logoTopConstraint = $0.top.equalToSuperview().offset(Metric.logoTop).constraint
      }
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

  func beginEditing(keyboardHeight: CGFloat) {
    UIView.animate(withDuration: 0.3) {
      self.scrollView.isScrollEnabled = true
      self.contentView.snp.updateConstraints {
        self.contentHeightConstraint = $0.height.equalToSuperview()
          .offset(keyboardHeight).constraint
      }
      self.scrollView.contentOffset.y += 50
      self.view.layoutIfNeeded()
    }
  }

  func endEditing() {
    UIView.animate(withDuration: 0.3) {
      self.scrollView.isScrollEnabled = false
      self.contentView.snp.updateConstraints {
        self.contentHeightConstraint = $0.height.equalToSuperview().constraint
      }
      self.scrollView.contentOffset.y = 0
      self.view.layoutIfNeeded()
    }
  }
}

//
//  SignUpViewController.swift
//  MyName
//
//  Created by hb1love on 30/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import NVActivityIndicatorView
import ReactorKit
import RxSwift
import Scope
import SnapKit

final class SignUpViewController: BaseViewController, ReactorView, NVActivityIndicatorViewable {

  // MARK: Constants

  private struct Metric {
    static let leadingTrailing = CGFloat(20)
    static let titleTop = CGFloat(230)
    static let titleHeight = CGFloat(60)
    static let fieldHeight = CGFloat(23)
    static let nameFieldTop = CGFloat(38)
    static let textFieldGap = CGFloat(28)
    static let termsLabelTop = CGFloat(23)
    static let buttonHeight = CGFloat(40)
    static let buttonGap = CGFloat(14)
    static let backButtonBottom = CGFloat(24)
    static let separatorGap = CGFloat(8)
    static let separatorHeight = CGFloat(1)
  }

  // MARK: - Subviews

  private var scrollView: UIScrollView!
  private var contentView: UIView!
  private var titleLabel: UILabel!
  private var nameField: UITextField!
  private var nameSeparatorView: UIView!
  private var emailField: UITextField!
  private var emailSeparatorView: UIView!
  private var passwordField: UITextField!
  private var passwordSeparatorView: UIView!
  private var signUpButton: UIButton!
  private var backButton: UIButton!
  private var termsLabel: UILabel!

  // MARK: - Properties

  private var contentHeightConstraint: Constraint?
  private var backButtonBottomConstraint: Constraint?

  // MARK: - Flow handler

  var onCompleteSignUp: (() -> Void)?
  var onCancel: (() -> Void)?

  // MARK: - Initialize

  init(
    reactor: SignUpViewReactor
    ) {
    super.init()
    self.modalTransitionStyle = .crossDissolve
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
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.top.equalToSuperview().offset(Metric.titleTop)
      $0.height.equalTo(Metric.titleHeight)
    }
    nameField.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.nameFieldTop)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.fieldHeight)
    }
    nameSeparatorView.snp.makeConstraints {
      $0.top.equalTo(nameField.snp.bottom).offset(Metric.separatorGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.separatorHeight)
    }
    emailField.snp.makeConstraints {
      $0.top.equalTo(nameSeparatorView.snp.bottom).offset(Metric.textFieldGap)
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
      $0.top.equalTo(emailSeparatorView.snp.bottom).offset(Metric.textFieldGap)
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
    termsLabel.snp.makeConstraints {
      $0.top.equalTo(passwordSeparatorView.snp.bottom).offset(Metric.termsLabelTop)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(Metric.fieldHeight)
    }
    signUpButton.snp.makeConstraints {
      $0.bottom.equalTo(backButton.snp.top).offset(-Metric.buttonGap)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
    }
    backButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.buttonHeight)
      backButtonBottomConstraint = $0.bottom.equalToSuperview().offset(-Metric.backButtonBottom).constraint
      backButtonBottomConstraint?.activate()
    }
  }
}

// MARK: - Configuring

extension SignUpViewController {

  func setupSubviews() {
    scrollView = UIScrollView().also {
      $0.isScrollEnabled = false
      view.addSubview($0)
    }
    contentView = UIView().also {
      scrollView.addSubview($0)
    }
    titleLabel = UILabel().also {
      $0.text = "Account?"
      $0.font = .preferredFont(type: .avantGardeITCTTDemi, size: 60)
      $0.textColor = .black0
      $0.alpha = 0
      contentView.addSubview($0)
    }
    nameField = UITextField().also {
      $0.placeholder = "name"
      $0.textColor = .black0
      $0.font = .preferredFont(type: .avenirLight, size: 20)
      $0.clearButtonMode = .whileEditing
      $0.alpha = 0
      contentView.addSubview($0)
    }
    nameSeparatorView = UIView().also {
      $0.backgroundColor = .separatorViewColor
      $0.alpha = 0
      contentView.addSubview($0)
    }
    emailField = UITextField().also {
      $0.placeholder = "email"
      $0.keyboardType = .emailAddress
      $0.textColor = .black0
      $0.font = .preferredFont(type: .avenirLight, size: 20)
      $0.clearButtonMode = .whileEditing
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
      $0.textColor = .black0
      $0.font = .preferredFont(type: .avenirLight, size: 20)
      $0.clearButtonMode = .whileEditing
      $0.clearsOnBeginEditing = true
      $0.returnKeyType = .send
      $0.alpha = 0
      contentView.addSubview($0)
    }
    passwordSeparatorView = UIView().also {
      $0.backgroundColor = .separatorViewColor
      $0.alpha = 0
      contentView.addSubview($0)
    }
    termsLabel = UILabel().also {
      $0.text = "By clicking \"join in\" I agree to mynameis's Terms of Service."
      $0.font = .preferredFont(type: .avenirLight, size: 12)
      $0.textColor = .gray9B
      $0.alpha = 0
      contentView.addSubview($0)
    }
    signUpButton = UIButton().also {
      $0.backgroundColor = .myNameColor
      $0.setTitleColor(.white, for: .normal)
      $0.setTitle("join in", for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 20)
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      contentView.addSubview($0)
    }
    backButton = UIButton().also {
      $0.backgroundColor = .clear
      $0.setTitleColor(.myNameColor, for: .normal)
      $0.setTitle("return to log in", for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 20)
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      contentView.addSubview($0)
    }
  }

  func bindAction(reactor: SignUpViewReactor) {
    keyboardHeight()
      .observeOn(MainScheduler.instance)
      .subscribe(onNext: { [weak self] keyboardHeight in
        keyboardHeight > 0 ? self?.beginEditing(keyboardHeight: keyboardHeight) : self?.endEditing()
      }).disposed(by: disposeBag)

    rx.viewWillAppear
      .subscribe(onNext: { [weak self] _ in
        analytics.log(.flowSignup)
        self?.navigationController?.setNavigationBarHidden(true, animated: true)
      }).disposed(by: disposeBag)

    rx.viewWillDisappear
      .subscribe(onNext: { [weak self] _ in
        self?.navigationController?.setNavigationBarHidden(false, animated: true)
      }).disposed(by: disposeBag)

    rx.viewDidAppear
      .subscribe(onNext: { [weak self] _ in
        self?.beginSignUpView()
      }).disposed(by: disposeBag)

    view.rx
      .tapGesture()
      .when(.recognized)
      .subscribe(onNext: { [weak self] _ in
        self?.view.endEditing(true)
      }).disposed(by: disposeBag)

    nameField.rx.controlEvent([.editingDidEndOnExit])
      .subscribe(onNext: { [weak self] in
        self?.emailField.becomeFirstResponder()
      }).disposed(by: disposeBag)

    emailField.rx.controlEvent([.editingDidEndOnExit])
      .subscribe(onNext: { [weak self] in
        self?.passwordField.becomeFirstResponder()
      }).disposed(by: disposeBag)

    passwordField.rx.controlEvent([.editingDidEndOnExit])
      .subscribe(onNext: { [weak self] in
        self?.view.endEditing(true)
      }).disposed(by: disposeBag)

//    signUpButton.rx.tap
//      .map { Reactor.Action.facebook }
//      .bind(to: reactor.action)
//      .disposed(by: disposeBag)

    signUpButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.onCompleteSignUp?()
      }).disposed(by: disposeBag)

    backButton.rx.tap
      .subscribe(onNext: { [weak self] in
        self?.onCancel?()
      }).disposed(by: disposeBag)
  }

  func bindState(reactor: SignUpViewReactor) {
    reactor.state.map { $0.isLoading }
      .distinctUntilChanged()
      .filter { $0 }
      .subscribe(onNext: { [weak self] _ in
        self?.startAnimating(CGSize(width: 30, height: 30))
      })
      .disposed(by: disposeBag)

//    reactor.state.map { $0.isLoggedIn }
//      .distinctUntilChanged()
//      .filter { $0 }
//      .subscribe(onNext: { [weak self] _ in
//        self?.onFinish?()
//      })
//      .disposed(by: disposeBag)
//
//    reactor.state.map { $0.isLoggedIn }
//      .distinctUntilChanged()
//      .filter { $0 }
//      .subscribe(onNext: { _ in
//        analytics.log(.login)
//      })
//      .disposed(by: disposeBag)
  }
}

private extension SignUpViewController {
  func beginSignUpView() {
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
      self.scrollView.contentOffset.y = 0
      self.titleLabel.alpha = 1
      self.nameField.alpha = 1
      self.nameSeparatorView.alpha = 1
      self.emailField.alpha = 1
      self.emailSeparatorView.alpha = 1
      self.passwordField.alpha = 1
      self.passwordSeparatorView.alpha = 1
      self.termsLabel.alpha = 1
      self.signUpButton.alpha = 1
      self.backButton.alpha = 1
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
      self.backButton.snp.updateConstraints {
        self.backButtonBottomConstraint = $0.bottom.equalToSuperview()
          .offset(-Metric.backButtonBottom - keyboardHeight).constraint
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
      self.backButton.snp.updateConstraints {
        self.backButtonBottomConstraint = $0.bottom.equalToSuperview().offset(-Metric.backButtonBottom).constraint
      }
      self.scrollView.contentOffset.y = 0
      self.view.layoutIfNeeded()
    }
  }
}

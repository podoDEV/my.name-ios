//
//  WelcomeViewController.swift
//  MyName
//
//  Created by hb1love on 09/06/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift
import Scope
import SideMenu
import SnapKit

final class WelcomeViewController: BaseViewController, ReactorView {

  // MARK: Constants

  private struct Metric {
    static let leadingTrailing = CGFloat(20)
    static let labelHeight = CGFloat(300)
    static let buttonHeight = CGFloat(40)
    static let buttonGap = CGFloat(14)
    static let buttonBottom = CGFloat(24)
  }

  // MARK: - Subviews

  private var welcomeLabel: UILabel!
  private var sideMenuItem: UIBarButtonItem!
  private var createButton: UIButton!

  // MARK: - Flow handler

  var onSelectSideMenu: (() -> Void)?
  var onCreateProfile: (() -> Void)?

  // MARK: - Initialize

  init(
    reactor: WelcomeViewReactor
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
    super.setupConstraints()
    welcomeLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.height.equalTo(Metric.labelHeight)
      $0.centerY.equalToSuperview()
    }
    createButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.bottom.equalToSuperview().offset(-Metric.buttonBottom)
      $0.height.equalTo(Metric.buttonHeight)
    }
  }
}

// MARK: - Configuring

extension WelcomeViewController {

  func setupSubviews() {
    sideMenuItem = UIBarButtonItem(
      image: UIImage(named: "ic_setting")!,
      style: .plain,
      target: nil,
      action: nil
    )
    navigationItem.rightBarButtonItem = sideMenuItem

    welcomeLabel = UILabel().also {
      $0.text = "Welcome\n"
      $0.font = .preferredFont(type: .avantGardeITCTTDemi, size: 72)
      $0.textAlignment = .center
      $0.numberOfLines = 3
      $0.alpha = 0
      view.addSubview($0)
    }
    createButton = UIButton().also {
      $0.backgroundColor = .myNameColor
      $0.setTitleColor(.white, for: .normal)
      $0.setTitle("create your own profile", for: .normal)
      $0.titleLabel?.font = .preferredFont(type: .avantGardeITCTTDemi, size: 20)
      $0.layer.cornerRadius = 20
      $0.clipsToBounds = true
      $0.alpha = 0
      view.addSubview($0)
    }
  }

  func bindAction(reactor: WelcomeViewReactor) {
    rx.viewWillAppear
      .map { Reactor.Action.refresh }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)

    rx.viewWillAppear
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.setNavigationBarHidden(false, animated: true)
        self?.navigationController?.navigationBar.barTintColor = .white
        analytics.log(.welcomeView)
      }).disposed(by: disposeBag)

    sideMenuItem.rx.tap
      .asDriver()
      .throttle(0.2)
      .drive(onNext: { [weak self] _ in
        self?.onSelectSideMenu?()
      }).disposed(by: disposeBag)

    createButton.rx.tap
      .asDriver()
      .throttle(0.2)
      .drive(onNext: { [weak self] _ in
        self?.onCreateProfile?()
      }).disposed(by: disposeBag)
  }

  func bindState(reactor: WelcomeViewReactor) {
    reactor.state.map { $0.name }
      .distinctUntilChanged()
      .filter { !$0.isEmpty }
      .subscribe(onNext: { [weak self] name in
        self?.beginWelcomeView(name)
      })
      .disposed(by: disposeBag)
  }
}

private extension WelcomeViewController {
  func beginWelcomeView(_ name: String) {
    self.welcomeLabel.text?.append(name)
    UIView.animate(
      withDuration: 1.0,
      animations: {
        self.welcomeLabel.alpha = 1
      },
      completion: { _ in
        UIView.animate(withDuration: 0.5, delay: 1.0, options: .curveLinear, animations: {
          self.welcomeLabel.alpha = 0
          self.createButton.alpha = 1
        })
      }
    )
  }
}

//
//  ProfileEditViewController.swift
//  MyName
//
//  Created by hb1love on 22/06/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class ProfileEditViewController: BaseViewController, ReactorView {

  // MARK: Constants

  private struct Metric {
    static let leadingTrailing = CGFloat(16)

    static let logoLoadingTop = CGFloat(220)
    static let logoTop = CGFloat(100)
    static let emailFieldTop = CGFloat(50)
    static let fieldHeight = CGFloat(20)
    static let buttonHeight = CGFloat(38)
    static let separatorGap = CGFloat(6)
    static let buttonGap = CGFloat(16)
    static let signUpButtonTop = CGFloat(50)
    static let separatorHeight = CGFloat(1)
  }

  // MARK: - Subviews

  private let item = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
  private var scrollView: UIScrollView!
  private var containerStackView: UIStackView!
  private var categoryLabelView: CategoryLabelView!

  // MARK: - Flow handler

  var onCancel: (() -> Void)?
  var onFinish: (() -> Void)?

  // MARK: - Initialize

  init(
    reactor: ProfileEditViewReactor
    ) {
    super.init()
    self.reactor = reactor
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func setupConstraints() {
//    categoryLabelView.snp.makeConstraints {
//      $0.
//    }
    scrollView.snp.makeConstraints {
      $0.leading.top.trailing.bottom.equalToSuperview()
    }
    containerStackView.snp.makeConstraints {
      $0.leading.top.trailing.bottom.width.equalToSuperview()
//      $0.height.equalToSuperview()
//      contentHeightConstraint = $0.height.equalToSuperview().constraint
//      contentHeightConstraint?.activate()
    }
//    logoLabel.snp.makeConstraints {
//      $0.leading.equalToSuperview().offset(Metric.logoLeadingTrailing)
//      $0.trailing.equalToSuperview().offset(-Metric.logoLeadingTrailing)
//      logoTopConstraint = $0.top.equalToSuperview().offset(Metric.logoLoadingTop).constraint
//      logoTopConstraint?.activate()
//    }
//    emailField.snp.makeConstraints {
//      $0.top.equalTo(logoLabel.snp.bottom).offset(Metric.emailFieldTop)
//      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
//      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
//      $0.height.equalTo(Metric.fieldHeight)
//    }
//    emailSeparatorView.snp.makeConstraints {
//      $0.top.equalTo(emailField.snp.bottom).offset(Metric.separatorGap)
//      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
//      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
//      $0.height.equalTo(Metric.separatorHeight)
//    }
//    passwordField.snp.makeConstraints {
//      $0.top.equalTo(emailSeparatorView.snp.bottom).offset(Metric.buttonGap)
//      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
//      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
//      $0.height.equalTo(Metric.fieldHeight)
  }
}

// MARK: - Configuring

extension ProfileEditViewController {

  func setupSubviews() {
    navigationItem.leftBarButtonItem = item
    scrollView = UIScrollView().also {
      $0.isScrollEnabled = true
      view.addSubview($0)
    }
    containerStackView = UIStackView().also {
      $0.axis = .vertical
      $0.alignment = .fill
      $0.distribution = .equalSpacing
      $0.spacing = 0
      scrollView.addSubview($0)
    }
    categoryLabelView = CategoryLabelView(title: "", subTitle: "").also {
      containerStackView.addArrangedSubview($0)
    }
//    contentView = UIView().also {
//      scrollView.addSubview($0)
//    }
//    logoLabel = UILabel().also {
//      $0.text = "my\nname\nis ___"
//      $0.font = .preferredFont(type: .avantGardeMdITCTTBold, size: 80)
//      $0.numberOfLines = 3
//      contentView.addSubview($0)
//    }
//
//    scrollView = UILabel().also {
//      $0.text = "Settings"
//      //      $0.font = .preferredFont(type: .calendar)
//      view.addSubview($0)
//    }
  }

  func bindAction(reactor: ProfileEditViewReactor) {
    rx.viewWillAppear
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.setNavigationBarHidden(false, animated: true)
        self?.navigationController?.navigationBar.barTintColor = .white
        analytics.log(.profileEditView)
      }).disposed(by: disposeBag)

    item.rx.tap
      .asDriver()
      .throttle(0.2)
      .drive(onNext: { [weak self] _ in
        self?.onFinish?()
      }).disposed(by: disposeBag)
  }

  func bindState(reactor: ProfileEditViewReactor) {}
}

//
//  PlaceholdableField.swift
//  MyName
//
//  Created by hb1love on 04/05/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import SnapKit

final class PlaceholdableField: BaseView {

  // MARK: Constants

  private struct Metric {
    static let placeholderHeight = CGFloat(20)
    static let textFieldTop = CGFloat(30)
  }

  // MARK: - Subviews

  private var textField: UITextField!
  private var placeholder: UILabel!

  // MARK: - Properties

  private var editingEndTopConstraint: Constraint?
  private var editingBeginTopConstraint: Constraint?
  private var raised: Bool = false

  // MARK: - Initialize
  
  override init() {
    super.init()
    setupSubviews()
    bindAction()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func setupConstraints() {
    textField.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.top.equalToSuperview().offset(Metric.textFieldTop)
    }
    placeholder.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Metric.placeholderHeight)
      editingEndTopConstraint = $0.top.equalTo(textField).constraint
      editingBeginTopConstraint = $0.top.equalToSuperview().constraint
      editingEndTopConstraint?.activate()
      editingBeginTopConstraint?.deactivate()
    }
  }
}

// MARK: - Configuring

extension PlaceholdableField {

  func setupSubviews() {
    textField = UITextField().also {
      $0.font = .preferredFont(type: .avantGardeITCTTDemi, size: 17)
      $0.textColor = .textColorBlack3C
    }
    placeholder = UILabel().also {
      $0.font = .preferredFont(type: .avantGardeITCTTDemi, size: 17)
      $0.textColor = .textColorBlack3C
    }
  }

  func bindAction() {
    textField.rx.controlEvent([.editingDidBegin])
      .filter { !self.raised }
      .subscribe(onNext: { [weak self] in
        self?.raised = true
        self?.editingBeginTopConstraint?.activate()
        self?.editingEndTopConstraint?.deactivate()
      }).disposed(by: disposeBag)

    textField.rx.controlEvent([.editingDidEndOnExit])
      .subscribe(onNext: { _ in
//        self?.view.endEditing(true)
      }).disposed(by: disposeBag)
  }
}

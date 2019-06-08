//
//  UnderlineTextField.swift
//  MyName
//
//  Created by hb1love on 18/05/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import SnapKit

final class UnderlineTextField: BaseView {

  // MARK: Constants

  private struct Metric {
    static let underlineHeight = CGFloat(1)
    static let textFieldHeight = CGFloat(20)
    static let textFieldBottom = CGFloat(3)
    static let textFieldTrailing = CGFloat(15)
    static let dotLeading = CGFloat(3)
    static let dotWidthHeight = CGFloat(15)
  }

  // MARK: - Subviews

  private var textField: UITextField!
  private var underlineView: UIView!
  private var dotView: UIView!

  // MARK: - Properties

//  private var editingEndTopConstraint: Constraint?
//  private var editingBeginTopConstraint: Constraint?
//  private var raised: Bool = false

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
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-Metric.textFieldBottom)
    }
    dotView.snp.makeConstraints {
      $0.leading.equalTo(underlineView.snp.trailing).offset(Metric.dotLeading)
      $0.trailing.lessThanOrEqualToSuperview()
      $0.baseline.equalTo(underlineView)
      $0.size.equalTo(CGSize(width: Metric.dotWidthHeight, height: Metric.dotWidthHeight))
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    underlineView.frame.size = CGSize(width: frame.width - Metric.dotWidthHeight, height: Metric.underlineHeight)
    underlineView.frame.origin.y = frame.maxY - Metric.underlineHeight
  }
}

// MARK: - Configuring

extension UnderlineTextField {

  func setupSubviews() {
    textField = UITextField().also {
      $0.textColor = .textColorBlack3C
      $0.font = .preferredFont(type: .avenirLight, size: 20)
      addSubview($0)
    }
    underlineView = UIView().also {
      $0.backgroundColor = .invalidUnderlineColor
      addSubview($0)
    }
    dotView = UIView().also {
      $0.backgroundColor = .invalidUnderlineColor
      addSubview($0)
    }
  }

  func bindAction() {
//    textField.rx.text.orEmpty
//      .subscribe(onNext: { [weak self] in
//        self?.textField.
//      }).disposed(by: disposeBag)
//
//    textField.rx.controlEvent([.editingDidBegin])
//      .filter { !self.raised }
//      .subscribe(onNext: { [weak self] in
//        self?.raised = true
//        self?.editingBeginTopConstraint?.activate()
//        self?.editingEndTopConstraint?.deactivate()
//      }).disposed(by: disposeBag)
//
//    textField.rx.controlEvent([.editingDidEndOnExit])
//      .subscribe(onNext: { _ in
//        //        self?.view.endEditing(true)
//      }).disposed(by: disposeBag)
  }
}

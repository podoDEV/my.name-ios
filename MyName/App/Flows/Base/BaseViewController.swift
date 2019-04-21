//
//  BaseViewController.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController, BaseUI {

  // MARK: Constraints

  private(set) var didSetupConstraints = false

  // MARK: Rx

  var disposeBag = DisposeBag()

  // MARK: Initializer

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.setNeedsUpdateConstraints()
//    self.view.backgroundColor = .white
  }

  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateViewConstraints()
  }

  func setupConstraints() {}
}

//
//  BaseTableViewCell.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell, BaseUI {

  // MARK: Constraints

  private(set) var didSetupConstraints = false

  // MARK: Rx

  var disposeBag = DisposeBag()

  // MARK: Initializer

  override func updateConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateConstraints()
  }

  func setupConstraints() {}
}

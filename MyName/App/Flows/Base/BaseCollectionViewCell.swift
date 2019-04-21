//
//  BaseCollectionViewCell.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import RxSwift

class BaseCollectionViewCell: UICollectionViewCell, BaseUI {

  // MARK: Constraints

  private(set) var didSetupConstraints = false

  // MARK: Rx

  var disposeBag = DisposeBag()

  // MARK: Initializer

  init() {
    super.init(frame: .zero)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func updateConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    super.updateConstraints()
  }

  func setupConstraints() {}
}

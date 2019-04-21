//
//  BaseUI.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import RxSwift

protocol BaseUI {
  var didSetupConstraints: Bool { get }
  var disposeBag: DisposeBag { get set }

  func setupConstraints()
}

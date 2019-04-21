//
//  UIViewController+Rx.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {

  var viewWillAppear: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.viewWillAppear))
      .map { _ in }
    return ControlEvent(events: source)
  }

  var viewDidAppear: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.viewDidAppear))
      .map { _ in }
    return ControlEvent(events: source)
  }

  var viewWillDisappear: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.viewWillDisappear))
      .map { _ in }
    return ControlEvent(events: source)
  }

  var viewDidDisappear: ControlEvent<Void> {
    let source = self.methodInvoked(#selector(Base.viewDidDisappear))
      .map { _ in }
    return ControlEvent(events: source)
  }
}

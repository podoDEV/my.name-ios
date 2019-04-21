//
//  Routable.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

protocol Routable: Presentable {

  func present(_ module: Presentable?, animated: Bool)

  func dismiss(animated: Bool, completion: (() -> Void)?)

  func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?)

  func pop(animated: Bool)

  func setRoot(_ module: Presentable?)

  func popToRoot(animated: Bool)
}

extension Routable {

  func present(
    _ module: Presentable?,
    animated: Bool = true
    ) {
    return present(module, animated: animated)
  }

  func dismiss(
    animate: Bool = true,
    completion: (() -> Void)? = nil
    ) {
    return dismiss(animated: animate, completion: completion)
  }

  func push(
    _ module: Presentable?,
    animated: Bool = true,
    completion: (() -> Void)? = nil
    ) {
    return push(module, animated: animated, completion: completion)
  }

  func pop(animated: Bool = true) {
    return pop(animated: animated)
  }

  func popToRoot(animated: Bool = true) {
    return popToRoot(animated: animated)
  }
}

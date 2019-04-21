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

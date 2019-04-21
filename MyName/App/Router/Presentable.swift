//
//  Presentable.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

protocol Presentable {
  func present() -> UIViewController?
}

extension UIViewController: Presentable {
  func present() -> UIViewController? {
    return self
  }
}

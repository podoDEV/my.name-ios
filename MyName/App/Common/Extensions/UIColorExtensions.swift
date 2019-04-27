//
//  UIColorExtensions.swift
//  MyName
//
//  Created by hb1love on 27/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int, alpha: Float) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")

    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: CGFloat(alpha)
    )
  }

  convenience init(hex: Int, alpha: Float = 1.0) {
    self.init(
      red: (hex >> 16) & 0xff,
      green: (hex >> 8) & 0xff,
      blue: hex & 0xff,
      alpha: alpha
    )
  }
}

//
//  Fonts.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

enum MyNameFont: String {
  case avantGardeMdITCTTBold = "AvantGardeMdITCTTBold"
  case avantGardeITCTTDemi = "AvantGardeITCTTDemi"
  case avantGardeBook = "AvantGardeBookBT"
}

extension UIFont {
  class func preferredFont(type: MyNameFont, size: CGFloat) -> UIFont {
    return UIFont(name: type.rawValue, size: size)!
  }
}

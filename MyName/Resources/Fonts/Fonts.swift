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
  case avantGardeBook = "AvantGardeITCbyBT-Book"
  case avenirBook = "Avenir-Book"
  case avenirLight = "Avenir-Light"
}

extension UIFont {
  class func preferredFont(type: MyNameFont, size: CGFloat) -> UIFont {
    return UIFont(name: type.rawValue, size: size)!
  }
}

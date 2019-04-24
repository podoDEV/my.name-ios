//
//  UIViewExtensions.swift
//  MyName
//
//  Created by hb1love on 25/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

extension UIView {

  @IBInspectable var shadow: Bool {
    get {
      return layer.shadowOpacity > 0.0
    }
    set {
      if newValue == true {
        self.addShadow()
      }
    }
  }

  @IBInspectable var cornerRadius: CGFloat {
    get {
      return self.layer.cornerRadius
    }
    set {
      self.layer.cornerRadius = newValue
      if shadow == false {
        self.layer.masksToBounds = true
      }
    }
  }

  func addShadow(
    shadowColor: CGColor = UIColor.black.cgColor,
    shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
    shadowOpacity: Float = 0.4,
    shadowRadius: CGFloat = 3.0
    ) {
    layer.shadowColor = shadowColor
    layer.shadowOffset = shadowOffset
    layer.shadowOpacity = shadowOpacity
    layer.shadowRadius = shadowRadius
  }
}

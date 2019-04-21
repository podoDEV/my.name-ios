//
//  Fonts.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

extension String {
  static var nanumBarunpenRegular = "NanumBarunpenR"
  static var nanumBarunpenBold = "NanumBarunpenB"
  static var nanumSquareLight = "NanumSquareRoundL"
  static var nanumSquareRegular = "NanumSquareRoundR"
  static var nanumSquareBold = "NanumSquareRoundB"
  static var binggraeTaom = "BinggraeTaom"
  static var binggraeTaomBold = "binggraeTaom-Bold"
  static var miSaeng = "SDMiSaeng"
}

enum MyNameFont {
  case nanumBarunpen
  case nanumSquare
  case binggraeTaom
  case misaeng

  func appFontL(size: CGFloat) -> UIFont {
    switch self {
    case .nanumBarunpen: // invalid
      return UIFont(name: .nanumBarunpenRegular, size: size)!
    case .nanumSquare:
      return UIFont(name: .nanumSquareLight, size: size)!
    case .binggraeTaom: // invalid
      return UIFont(name: .binggraeTaom, size: size)!
    case .misaeng:
      return UIFont(name: .miSaeng, size: size)!
    }
  }

  func appFontR(size: CGFloat) -> UIFont {
    switch self {
    case .nanumBarunpen:
      return UIFont(name: .nanumBarunpenRegular, size: size)!
    case .nanumSquare:
      return UIFont(name: .nanumSquareRegular, size: size)!
    case .binggraeTaom:
      return UIFont(name: .binggraeTaom, size: size)!
    case .misaeng:
      return UIFont(name: .miSaeng, size: size)!
    }
  }

  func appFontM(size: CGFloat) -> UIFont {
    switch self {
    case .nanumBarunpen: // invalid
      return UIFont(name: .nanumBarunpenRegular, size: size)!
    case .nanumSquare: // invalid
      return UIFont(name: .nanumSquareRegular, size: size)!
    case .binggraeTaom: // invalid
      return UIFont(name: .binggraeTaom, size: size)!
    case .misaeng: // invalid
      return UIFont(name: .miSaeng, size: size)!
    }
  }

  func appFontB(size: CGFloat) -> UIFont {
    switch self {
    case .nanumBarunpen:
      return UIFont(name: .nanumBarunpenBold, size: size)!
    case .nanumSquare:
      return UIFont(name: .nanumSquareBold, size: size)!
    case .binggraeTaom:
      return UIFont(name: .binggraeTaomBold, size: size)!
    case .misaeng: // invalid
      return UIFont(name: .miSaeng, size: size)!
    }
  }
}

extension MyNameFont {

  var calendar: UIFont {
    switch self {
    case .nanumBarunpen:
      return appFontM(size: 15)
    case .nanumSquare:
      return appFontM(size: 15)
    case .binggraeTaom:
      return appFontM(size: 15)
    case .misaeng:
      return appFontM(size: 15)
    }
  }
}

extension UIFont {

  enum ContentType {
    case calendar
    case settings
    case misc
  }

  static var appFont: MyNameFont = .nanumSquare

  class func preferredFont(type: ContentType) -> UIFont {
    switch type {
    case .calendar:
      return UIFont.appFont.calendar
    case .settings:
      return UIFont.appFont.calendar
    case .misc:
      return UIFont.appFont.calendar
    }
  }
}

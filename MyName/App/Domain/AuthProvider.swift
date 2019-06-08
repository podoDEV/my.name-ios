//
//  AuthProvider.swift
//  MyName
//
//  Created by hb1love on 27/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

enum AuthProvider {
  case podo(Account)
  case google(AccessToken)
  case facebook(AccessToken)

  var rawValue: String {
    switch self {
    case .podo: return "podo"
    case .google: return "google"
    case .facebook: return "facebook"
    }
  }
}

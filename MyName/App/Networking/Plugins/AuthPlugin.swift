//
//  AuthPlugin.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Moya

struct AuthPlugin: PluginType {
  private let authService: AuthServiceType

  init(authService: AuthServiceType) {
    self.authService = authService
  }

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request
    if let session = self.authService.current {
      request.addValue(session, forHTTPHeaderField: "Cookie")
    }
    return request
  }
}

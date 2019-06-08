//
//  AuthAPI.swift
//  MyName
//
//  Created by hb1love on 18/05/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

import Moya

enum AuthAPI {
  case login(provider: AuthProvider)
}

extension AuthAPI: TargetType {

  var baseURL: URL {
    return URL(string: "https://myshort.info/api")!
  }

  var path: String {
    switch self {
    case .login(let provider):
      return "auth/login/\(provider.rawValue)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .login:
      return .post
    }
  }

  var task: Task {
    switch self {
    case .login(let provider):
      switch provider {
      case .podo(let account):
        return .requestParameters(
          parameters: ["email": "\(account.email)", "password": "\(account.password)"],
          encoding: JSONEncoding.default
        )
      case .google(let token):
        return .requestParameters(
          parameters: ["accessToken": "\(token.id)"],
          encoding: JSONEncoding.default
        )
      case .facebook(let token):
        return .requestParameters(
          parameters: ["accessToken": "\(token.id)"],
          encoding: JSONEncoding.default
        )
      }

      //    case .loginOAuth(let provider):
      //      return .requestCompositeParameters(
      //        bodyParameters: [:],
      //        bodyEncoding: JSONEncoding.default,
      //        urlParameters: ["provider": "\(provider)"]
    //      )
    }
  }

  var headers: [String: String]? {
    return ["Content-Type": "application/json",
            "X-PODO-CALLER": "IOS"]
  }

  var sampleData: Data {
    switch self {
    default:
      return Data()
    }
  }
}

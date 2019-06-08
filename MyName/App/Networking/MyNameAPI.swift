//
//  MyNameAPI.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

import Moya

enum MyNameAPI {
  case me
  case member(id: Int)
}

extension MyNameAPI: TargetType {

  var baseURL: URL {
    return URL(string: "https://myshort.info/api")!
  }

  var path: String {
    switch self {
    case .me:
      return "members/me"
    case .member(let id):
      return "members/\(id)"
    }
  }

  var method: Moya.Method {
    switch self {
    case .me,
         .member:
      return .get
    }
  }

  var task: Task {
    switch self {

//    case .loginOAuth(let provider):
//      return .requestCompositeParameters(
//        bodyParameters: [:],
//        bodyEncoding: JSONEncoding.default,
//        urlParameters: ["provider": "\(provider)"]
//      )
    default:
      return .requestPlain
    }
  }

  var headers: [String: String]? {
    return ["Content-Type": "application/json",
            "X-PODO-CALLER": "IOS"]
  }

  var sampleData: Data {
    switch self {
    case .me:
      return "{\"login\": \"asd\", \"id\": 100}".data(using: String.Encoding.utf8)!
    default:
      return Data()
    }
  }
}

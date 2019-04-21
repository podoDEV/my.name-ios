//
//  MyNameAPI.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Moya

enum MyNameAPI {
  case me
  case member(id: Int)
}

extension MyNameAPI: TargetType {

  var baseURL: URL {
    return URL(string: "http://myshort.info/api")!
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
//    case .me:
//      return .requestParameters(parameters: ["sort": "pushed"], encoding: URLEncoding.default)
    default:
      return .requestPlain
    }
  }

  var headers: [String: String]? {
    return ["Accept": "application/json"]
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
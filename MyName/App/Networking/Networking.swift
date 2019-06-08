//
//  Networking.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Moya
import RxSwift

typealias AuthNetworking = Networking<AuthAPI>
typealias MyNameNetworking = Networking<MyNameAPI>

final class Networking<Target: TargetType>: MoyaProvider<Target> {

  init(plugins: [PluginType] = []) {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 10

    let manager = Manager(configuration: configuration)
    manager.startRequestsImmediately = false
    super.init(manager: manager, plugins: plugins)
  }

  func request(
    _ target: Target,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
    ) -> Single<Response> {
    let requestString = "\(target.method) \(target.path)"
    return self.rx.request(target)
      .filterSuccessfulStatusCodes()
      .do(
        onSuccess: { value in
          let message = "SUCCESS: \(requestString) (\(value.statusCode))"
          log.debug(message)
        },
        onError: { error in
          if let response = (error as? MoyaError)?.response {
            if let jsonObject = try? response.mapJSON(failsOnEmptyData: false) {
              let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(jsonObject)"
              log.warning(message)
            } else if let rawString = String(data: response.data, encoding: .utf8) {
              let message = "FAILURE: \(requestString) (\(response.statusCode))\n\(rawString)"
              log.warning(message)
            } else {
              let message = "FAILURE: \(requestString) (\(response.statusCode))"
              log.warning(message)
            }
          } else {
            let message = "FAILURE: \(requestString)\n\(error)"
            log.warning(message)
          }
        },
        onSubscribed: {
          let message = "REQUEST: \(requestString)"
          log.debug(message)
        }
      )
  }
}

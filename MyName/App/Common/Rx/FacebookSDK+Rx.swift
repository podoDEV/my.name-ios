//
//  FacebookSDK+Rx.swift
//  MyName
//
//  Created by hb1love on 22/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Foundation

import FBSDKCoreKit
import FBSDKLoginKit
import RxSwift

enum FacebookSDKError: Error {
  case tokenNotFound
}

extension Reactive where Base: FBSDKLoginManager {
  func login(from: UIViewController? = nil) -> Observable<String> {
    return Observable.create { observer in
      self.base.logIn(withReadPermissions: ["public_profile", "email"], from: from) { result, error in
        if let error = error {
          observer.onError(error)
          return
        }

        guard let token = result?.token else {
          observer.onError(FacebookSDKError.tokenNotFound)
          return
        }

        observer.onNext(token.tokenString)
        observer.onCompleted()
      }

      return Disposables.create()
    }
  }
}

extension Reactive where Base: FBSDKGraphRequest {
  typealias MeResponse = (name: String?, email: String?, gender: String?, birthday: String?, photos: [String]?)

  static func fetchMe() -> Observable<MeResponse> {
    return Observable.create { observer in
      let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email, gender, birthday, photos"])
      let task = request?.start { _, result, error in
        if let error = error {
          observer.onError(error)
          return
        }

        guard let result = result as? [AnyHashable: Any] else {
          observer.onError(FacebookSDKError.tokenNotFound)
          return
        }

        let name = result["name"] as? String
        let email = result["email"] as? String
        let gender = result["gender"] as? String
        let birthday = result["birthday"] as? String
        let photos = result["photos"] as? [String]

        let response = MeResponse(name: name, email: email, gender: gender, birthday: birthday, photos: photos)
        observer.onNext(response)
        observer.onCompleted()
      }

      return Disposables.create {
        task?.cancel()
      }
    }
  }
}

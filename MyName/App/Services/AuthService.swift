//
//  AuthService.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import Alamofire
import KeychainAccess
import RxSwift

protocol AuthServiceType {
  var currentAccessToken: AccessToken? { get }

  func authorize(_ accessToken: AccessToken) -> Observable<Void>
  func logout()
}

final class AuthService: AuthServiceType {

  private let keychain = Keychain(service: "com.podo.myname")
  private(set) var currentAccessToken: AccessToken?

  init() {
    self.currentAccessToken = loadAccessToken()
    log.debug("currentAccessToken exists: \(self.currentAccessToken != nil)")
  }

  func authorize(_ accessToken: AccessToken) -> Observable<Void> {
    return Observable.create { observer in
      
      return Disposables.create()
    }
  }

  func logout() {}
}

private extension AuthService {

  func saveAccessToken(_ accessToken: AccessToken) throws {
    try keychain.set(accessToken.id, key: "access_token_id")
  }

  func loadAccessToken() -> AccessToken? {
    guard let id = keychain["access_token_id"] else { return nil }
    return AccessToken(id: id)
  }

  func deleteAccessToken() {
    try? keychain.remove("access_token_id")
  }
}

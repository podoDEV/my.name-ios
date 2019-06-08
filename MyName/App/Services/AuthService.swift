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
  var current: Session? { get }

  func authorize(_ provider: AuthProvider) -> Single<Void>
  func logout()
}

final class AuthService: AuthServiceType {
  private let networking: AuthNetworking

  private let keychain = Keychain(service: "com.podo.myname")
  private(set) var current: Session?

  init(networking: AuthNetworking) {
    self.networking = networking
    self.current = loadSession()
    log.debug("currentSession exists: \(self.current != nil)")
  }

  func authorize(_ provider: AuthProvider) -> Single<Void> {
    return networking.request(.login(provider: provider))
      .do(onSuccess: { [weak self] response in
        guard let headers = response.response?.allHeaderFields as? [String: AnyObject] else { return }
        guard let session = headers["Set-Cookie"] as? Session else { return }
        self?.current = session
        try? self?.saveSession(session)
      })
      .map { _ in }
  }

  func logout() {}
}

private extension AuthService {

  func saveSession(_ session: Session) throws {
    try keychain.set(session, key: "session")
  }

  func loadSession() -> Session? {
    guard let value = keychain["session"] else { return nil }
    return Session(value)
  }

  func deleteSession() {
    try? keychain.remove("session")
  }
}

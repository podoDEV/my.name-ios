//
//  RxGIDSignInDelegateProxy.swift
//  MyName
//
//  Created by hb1love on 23/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import GoogleSignIn
import RxCocoa
import RxSwift

class RxGIDSignInDelegateProxy
  : DelegateProxy<GIDSignIn, GIDSignInDelegate>
  , DelegateProxyType
  , GIDSignInDelegate {

  private(set) weak var gidSignIn: GIDSignIn?

  let signInSubject = PublishSubject<GIDGoogleUser>()
  let disconnectSubject = PublishSubject<GIDGoogleUser>()

  class func currentDelegate(for object: ParentObject) -> GIDSignInDelegate? {
    return object.delegate
  }

  class func setCurrentDelegate(_ delegate: GIDSignInDelegate?, to object: ParentObject) {
    object.delegate = delegate
  }

  init(gidSignIn: ParentObject) {
    super.init(parentObject: gidSignIn, delegateProxy: RxGIDSignInDelegateProxy.self)
  }

  static func registerKnownImplementations() {
    self.register { RxGIDSignInDelegateProxy(gidSignIn: $0) }
  }

  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if let user = user {
      self.signInSubject.onNext(user)
    } else if let error = error {
      self.signInSubject.onError(error)
    }
    self._forwardToDelegate?.sign(signIn, didSignInFor: user, withError: error)
  }

  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    if let user = user {
      self.disconnectSubject.onNext(user)
    } else if let error = error {
      self.disconnectSubject.onError(error)
    }
    self._forwardToDelegate?.sign(signIn, didDisconnectWith: user, withError: error)
  }

  deinit {
    self.signInSubject.onCompleted()
    self.disconnectSubject.onCompleted()
  }
}

extension Reactive where Base: GIDSignIn {

  private var gidSignInDelegate: RxGIDSignInDelegateProxy {
    return RxGIDSignInDelegateProxy.proxy(for: base)
  }

  var signIn: Observable<GIDGoogleUser> {
    return gidSignInDelegate.signInSubject.asObservable()
//    let proxy = self.gidSignInDelegate
//    proxy.signInSubject = PublishSubject<GIDGoogleUser>()
//    return proxy.signInSubject
//      .asObservable()
//      .do(onSubscribed: {
//        proxy.gidSignIn?.signIn()
//      })
//      .take(1)
//      .asSingle()
  }

  private var signOut: Observable<GIDGoogleUser> {
    return gidSignInDelegate.disconnectSubject.asObservable()
  }
}

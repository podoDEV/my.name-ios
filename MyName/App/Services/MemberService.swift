//
//  MemberService.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import RxSwift

protocol MemberServiceType {
  var currentUser: Observable<User?> { get }

  func me() -> Single<Void>
}

final class MemberService: MemberServiceType {
  private let networking: MyNameNetworking

  private let userSubject = ReplaySubject<User?>.create(bufferSize: 1)
  private(set) lazy var currentUser: Observable<User?> = self.userSubject.asObserver()
    .startWith(nil)
    .share(replay: 1)

  init(networking: MyNameNetworking) {
    self.networking = networking
  }

  func me() -> Single<Void> {
    return networking.request(.me)
      .map(User.self)
      .do(onSuccess: { [weak self] user in
        self?.userSubject.onNext(user)
      })
      .map { _ in }
  }
}

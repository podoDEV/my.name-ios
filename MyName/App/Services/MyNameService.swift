//
//  MyNameService.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import RxSwift

protocol MyNameServiceType {
  func getProfile()
}

class MyNameService: MyNameServiceType {
  private let networking: MyNameNetworking

  init(networking: MyNameNetworking) {
    self.networking = networking
  }

  func getProfile() {}
}

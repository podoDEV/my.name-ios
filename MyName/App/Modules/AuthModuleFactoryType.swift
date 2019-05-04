//
//  AuthModuleFactoryType.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol AuthModuleFactoryType {
  func makeLoginModule() -> LoginViewController
  func makeSignUpModule() -> SignUpViewController
}

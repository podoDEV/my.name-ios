//
//  MainModuleFactoryType.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

protocol MainModuleFactoryType {
  func makeWelcomeModule() -> WelcomeViewController
  func makeProfileDetailModule() -> ProfileDetailViewController
}

//
//  ApplicationInjector.swift
//  MyName
//
//  Created by hb1love on 21/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import Firebase
import GoogleSignIn
import SwiftyBeaver
import Swinject
import Umbrella

let container = Container()

struct AppDependency {
  let window: UIWindow
  let coordinator: ApplicationCoordinator
  let configureSDKs: () -> Void
  let configureAppearance: () -> Void
}

struct ApplicationInjector {
  static func resolve() -> AppDependency {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let rootController = UINavigationController()
    window.rootViewController = rootController
    window.backgroundColor = .white
    window.makeKeyAndVisible()

    container.register(CoordinatorFactory.self) { _ in CoordinatorFactory() }

    let cordinator = ApplicationCoordinator(
      coordinatorFactory: container.resolve(CoordinatorFactory.self)!,
      router: Router(rootController: rootController)
    )

    container.register(AuthService.self) { _ in AuthService() }
    container.register(MyNameNetworking.self) { r in
      let authService = r.resolve(AuthService.self)!
      return MyNameNetworking(plugins: [AuthPlugin(authService: authService)])
    }
    container.register(MemberService.self) { r in
      let networking = r.resolve(MyNameNetworking.self)!
      return MemberService(networking: networking)
    }

    container.register(ModuleFactory.self) { _ in ModuleFactory() }

    return AppDependency(
      window: window,
      coordinator: cordinator,
      configureSDKs: configureSDKs,
      configureAppearance: configureAppearance
    )
  }

  static func configureSDKs() {
    configureLogger()
    configureAnalytics()
    configureOAuth()
  }

  static func configureLogger() {
    let console = ConsoleDestination()
    let cloud = SBPlatformDestination(
      appID: "OknvLv",
      appSecret: "yrruwindu5ExuIhP9brLZb6FqouoEzbk",
      encryptionKey: "ijaqbchoybfe6uyjlInfexirMrfcvVaY"
    )
    log.addDestination(console)
    log.addDestination(cloud)
  }

  static func configureAnalytics() {
    FirebaseApp.configure()
    analytics.register(provider: FirebaseProvider())
  }

  static func configureAppearance() {
    UINavigationBar.appearance().shadowImage = UIImage()
  }

  static func configureOAuth() {
    GIDSignIn.sharedInstance().clientID = "131962867282-m786hjkvd137ndjkv8ikj8v2eqetpo5n.apps.googleusercontent.com"
  }
}

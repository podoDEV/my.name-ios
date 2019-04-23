//
//  AppDelegate.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  private var dependency: AppDependency!

  private var window: UIWindow?

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
    self.dependency = self.dependency ?? ApplicationInjector.resolve()
    self.dependency.configureSDKs()
    self.dependency.configureAppearance()
    self.window = self.dependency.window
    self.dependency.coordinator.start()
//    let notification = launchOptions?[.remoteNotification] as? [String: AnyObject]
//    let deepLink = DeepLinkOption.build(with: notification)
    return true
  }

  func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
//    let deepLink = DeepLinkOption.build(with: userActivity)
//    applicationCoordinator.start(with: deepLink)
    return true
  }

  func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
    return GIDSignIn.sharedInstance().handle(
      url,
      sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
      annotation: options[UIApplication.OpenURLOptionsKey.annotation]
    )
  }

  func application(
    _ application: UIApplication,
    open url: URL,
    sourceApplication: String?,
    annotation: Any
    ) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(
      application,
      open: url,
      sourceApplication: sourceApplication,
      annotation: annotation
    )
  }
}

//
//  Router.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class Router: NSObject, Routable {

  private weak var rootController: UINavigationController?
  private var completions: [UIViewController: () -> Void]

  init(rootController: UINavigationController) {
    self.rootController = rootController
    completions = [:]
  }

  func present() -> UIViewController? {
    return rootController
  }

  func present(_ module: Presentable?, animated: Bool = true) {
    guard let controller = module?.present() else { return }
    rootController?.present(controller, animated: animated, completion: nil)
  }

  func dismiss(animated: Bool, completion: (() -> Void)?) {
    rootController?.dismiss(animated: animated, completion: completion)
  }

  func push(
    _ module: Presentable?,
    animated: Bool = true,
    completion: (() -> Void)? = nil
    ) {
    guard
      let controller = module?.present(),
      (controller is UINavigationController == false)
      else {
        assertionFailure("Deprecated push UINavigationController.")
        return
    }

    if let completion = completion {
      completions[controller] = completion
    }
    rootController?.pushViewController(controller, animated: animated)
  }

  func pop(animated: Bool = true) {
    if let controller = rootController?.popViewController(animated: animated) {
      runCompletion(for: controller)
    }
  }

  func setRoot(_ module: Presentable?) {
    guard let controller = module?.present() else { return }
    rootController?.setViewControllers([controller], animated: false)
  }

  func popToRoot(animated: Bool) {
    if let controllers = rootController?.popToRootViewController(animated: animated) {
      controllers.forEach { controller in
        runCompletion(for: controller)
      }
    }
  }
}

extension Router {

  private func runCompletion(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }
    completion()
    completions.removeValue(forKey: controller)
  }
}

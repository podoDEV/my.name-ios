//
//  Coordinator.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

protocol Coordinator: AnyObject {
//  var container: Container { get }
  var childCoordinators: [Coordinator] { get set }
  func start()
}

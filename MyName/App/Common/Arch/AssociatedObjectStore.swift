//
//  AssociatedObjectStore.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import ObjectiveC

public protocol AssociatedObjectStore {
}

extension AssociatedObjectStore {
  func associatedObject<T>(forKey key: UnsafeRawPointer) -> T? {
    return objc_getAssociatedObject(self, key) as? T
  }

  func associatedObject<T>(forKey key: UnsafeRawPointer, default: @autoclosure () -> T) -> T {
    if let object: T = self.associatedObject(forKey: key) {
      return object
    }
    let object = `default`()
    self.setAssociatedObject(object, forKey: key)
    return object
  }

  func setAssociatedObject<T>(_ object: T?, forKey key: UnsafeRawPointer) {
    objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}

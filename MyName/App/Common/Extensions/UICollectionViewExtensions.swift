//
//  UICollectionViewExtensions.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

protocol CollectionViewCellType {
  static var identifier: String { get }
}

extension UICollectionViewCell: CollectionViewCellType {
  static var identifier: String { return String(describing: self.self) }
}

extension UICollectionView {

  func registerNib<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
    ) where Cell: UICollectionViewCell {
    register(
      UINib(nibName: reuseIdentifier, bundle: nil),
      forCellWithReuseIdentifier: reuseIdentifier
    )
  }

  func register<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
    ) where Cell: UICollectionViewCell {
    register(cell, forCellWithReuseIdentifier: reuseIdentifier)
  }
}

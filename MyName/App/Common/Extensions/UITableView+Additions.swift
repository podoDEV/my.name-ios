//
//  UITableView+Additions.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

protocol TableViewCellType {
  static var identifier: String { get }
}

extension UITableViewCell: TableViewCellType {
  static var identifier: String { return String(describing: self.self) }
}

extension UITableViewHeaderFooterView: TableViewCellType {
  static var identifier: String { return String(describing: self.self) }
}

extension UITableView {

  func registerNib<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
    ) where Cell: UITableViewCell {
    register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
  }

  func register<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
    ) where Cell: UITableViewCell {
    register(cell, forCellReuseIdentifier: reuseIdentifier)
  }

  func register<Cell>(
    cell: Cell.Type,
    forCellReuseIdentifier reuseIdentifier: String = Cell.identifier
    ) where Cell: UITableViewHeaderFooterView {
    register(cell, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
  }
}

extension UITableView {

  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewCell {
    return dequeueReusableCell(withIdentifier: reusableCell.identifier) as? Cell
  }

  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell? where Cell: UITableViewHeaderFooterView {
    return dequeueReusableHeaderFooterView(withIdentifier: reusableCell.identifier) as? Cell
  }
}

//
//  ReactorView.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

#if !os(Linux)
import RxSwift
import ReactorKit

/// A View displays data. A view controller and a cell are treated as a view. The view binds user
/// inputs to the action stream and binds the view states to each UI component. There's no business
/// logic in a view layer. A view just defines how to map the action stream and the state stream.
protocol ReactorView: class, AssociatedObjectStore {
  associatedtype Reactor: ReactorKit.Reactor

  /// A dispose bag. It is disposed each time the `reactor` is assigned.
  var disposeBag: DisposeBag { get set }

  /// A view's reactor. `bind(reactor:)` gets called when the new value is assigned to this property.
  var reactor: Reactor? { get set }

  func setupSubviews()
  /// Creates RxSwift bindings. This method is called each time the `reactor` is assigned.
  ///
  /// Here is a typical implementation example:
  ///
  /// ```
  /// func bind(reactor: MyReactor) {
  ///   // Action
  ///   increaseButton.rx.tap
  ///     .bind(to: Reactor.Action.increase)
  ///     .disposed(by: disposeBag)
  ///
  ///   // State
  ///   reactor.state.map { $0.count }
  ///     .bind(to: countLabel.rx.text)
  ///     .disposed(by: disposeBag)
  /// }
  /// ```
  ///
  /// - warning: It's not recommended to call this method directly.
  func bindAction(reactor: Reactor)
  func bindState(reactor: Reactor)
}

// MARK: - Associated Object Keys
var reactorKey = "reactor"
var isReactorBindedKey = "isReactorBinded"

// MARK: - Default Implementations
extension ReactorView {
  public var reactor: Reactor? {
    get { return self.associatedObject(forKey: &reactorKey) }
    set {
      self.setAssociatedObject(newValue, forKey: &reactorKey)
      self.disposeBag = DisposeBag()
      if let reactor = newValue {
        self.setupSubviews()
        self.bindAction(reactor: reactor)
        self.bindState(reactor: reactor)
      }
    }
  }
}
#endif

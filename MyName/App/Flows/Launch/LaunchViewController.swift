//
//  LaunchViewController.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import Hero
import ReactorKit
import RxSwift
import SnapKit

final class LaunchViewController: BaseViewController, ReactorView {

  // MARK: Constants

  private struct Metric {
    static let leadingTrailing = CGFloat(40)
    static let top = CGFloat(220)
  }

  // MARK: - Subviews

  private var scrollView: UIScrollView!
  private var contentView: UIView!
  private var logoLabel: UILabel!

  // MARK: - Flow handler

  var onFinish: (() -> Void)?

  // MARK: - Initialize

  init(
    reactor: LaunchViewReactor
    ) {
    super.init()
    self.reactor = reactor
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func setupConstraints() {
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    contentView.snp.makeConstraints {
      $0.edges.width.height.equalToSuperview()
    }
    logoLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.top.equalToSuperview().offset(Metric.top + 20)
    }
  }
}

// MARK: - Configuring

extension LaunchViewController {

  func setupSubviews() {
    for family in UIFont.familyNames.sorted() {
      let names = UIFont.fontNames(forFamilyName: family)
      log.debug("Family: \(family) Font names: \(names)")
    }

    scrollView = UIScrollView().also {
      $0.isScrollEnabled = false
      view.addSubview($0)
    }
    contentView = UIView().also {
      scrollView.addSubview($0)
    }
    logoLabel = UILabel().also {
      $0.text = "my\nname\nis ___"
      $0.font = .preferredFont(type: .avantGardeMdITCTTBold, size: 80)
      $0.numberOfLines = 3
      $0.alpha = 0
      scrollView.addSubview($0)
    }
  }

  func bindAction(reactor: LaunchViewReactor) {
    rx.viewWillAppear
      .subscribe(onNext: { [weak self] _ in
        analytics.log(.flowLaunch)
        self?.navigationController?.setNavigationBarHidden(true, animated: true)
      }).disposed(by: disposeBag)

    rx.viewWillDisappear
      .subscribe(onNext: { [weak self] _ in
        self?.navigationController?.setNavigationBarHidden(false, animated: true)
      }).disposed(by: disposeBag)

    rx.viewDidAppear
      .subscribe(onNext: { [weak self] _ in
        self?.entryLaunchView()
      }).disposed(by: disposeBag)

    rx.viewDidAppear
      .delay(1, scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        self?.onFinish?()
      }).disposed(by: disposeBag)
  }

  func bindState(reactor: LaunchViewReactor) {}
}

// MARK: - Animation

private extension LaunchViewController {

  func entryLaunchView() {
    UIView.animate(withDuration: 1, animations: { [weak self] in
      self?.logoLabel.let {
        $0.snp.updateConstraints {
          $0.top.equalToSuperview().offset(Metric.top)
        }
        $0.alpha = 1
      }
      self?.view.layoutIfNeeded()
    })
  }
}

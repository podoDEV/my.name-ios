//
//  MainViewController.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

import ReactorKit
import RxSwift
import Scope
import SideMenu
import SnapKit

final class MainViewController: BaseViewController, ReactorView {

  // MARK: Constants

  private struct Metric {
    static let leadingTrailing = CGFloat(30)
    static let navigationTop = CGFloat(80)
    static let navigationItemSize = CGFloat(30)
    static let calendarTop = CGFloat(60)
    static let calendarHeight = CGFloat(300)
    static let cardTop = CGFloat(30)
  }

  // MARK: - Subviews

  private var sideMenuButton: UIButton!
  private var settingButton: UIButton!
//  private var cardView: CardView!

  // MARK: - Flow handler

  var onSelectSetting: (() -> Void)?
  var onCreateNote: (() -> Void)?

  // MARK: - Initialize

  init(reactor: MainViewReactor) {
    super.init()
    self.reactor = reactor
    self.modalTransitionStyle = .crossDissolve
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func setupConstraints() {
    super.setupConstraints()
    sideMenuButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(Metric.navigationTop)
      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
      $0.size.equalTo(Metric.navigationItemSize)
    }
    settingButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(Metric.navigationTop)
      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
      $0.size.equalTo(Metric.navigationItemSize)
    }
//    cardView.snp.makeConstraints {
//      $0.top.equalTo(calendarView.snp.bottom).offset(Metric.cardTop)
//      $0.leading.equalToSuperview().offset(Metric.leadingTrailing)
//      $0.trailing.equalToSuperview().offset(-Metric.leadingTrailing)
//    }
  }
}

// MARK: - Configuring

extension MainViewController {

  func setupSubviews() {
    sideMenuButton = UIButton().also {
      $0.setImage(UIImage(named: "ic_lnb")!, for: .normal)
      view.addSubview($0)
    }
    settingButton = UIButton().also {
      $0.setImage(UIImage(named: "ic_setting")!, for: .normal)
      view.addSubview($0)
    }
//    cardView = CardView().also {
//      $0.backgroundColor = .red
//      view.addSubview($0)
//    }
  }

  func bindAction(reactor: MainViewReactor) {
//    calendarView.reactor = reactor.calendarViewReactor

    rx.viewWillAppear
      .subscribe(onNext: { _ in
        self.navigationController?.setNavigationBarHidden(true, animated: true)
      }).disposed(by: disposeBag)

    rx.viewDidAppear
      .subscribe(onNext: { _ in
        analytics.log(.flowMain)
      }).disposed(by: disposeBag)

    rx.viewWillDisappear
      .subscribe(onNext: { _ in
        self.navigationController?.setNavigationBarHidden(false, animated: true)
      }).disposed(by: disposeBag)

//    calendarView.onSelected
//      .asObserver()
//      .observeOn(MainScheduler.instance)
//      .subscribe(onNext: { date in
//        log.info("selected Date: ", context: date)
//      }).disposed(by: disposeBag)
  }

  func bindState(reactor: MainViewReactor) {}
}

//
//  CategoryLabelView.swift
//  MyName
//
//  Created by hb1love on 06/07/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class CategoryLabelView: BaseView {

  // MARK: Constants

  private struct Metric {
    static let subTitleMinHeight = CGFloat(21)
  }

  // MARK: - Subviews

  private var titleLabel: UILabel!
  private var subTitleLabel: UILabel!

  // MARK: - Properties

  var title: String?
  var subTitle: String?

  // MARK: - Initialize

  init(title: String?, subTitle: String?) {
    super.init()
    self.title = title
    self.subTitle = subTitle
    setupSubviews()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Life Cycle

  override func setupConstraints() {
    titleLabel.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview()
      $0.bottom.equalTo(subTitleLabel.snp.top)
    }
    subTitleLabel.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.greaterThanOrEqualTo(Metric.subTitleMinHeight)
    }
  }
}

// MARK: - Configuring

extension CategoryLabelView {

  func setupSubviews() {
    titleLabel = UILabel().also {
      $0.font = .preferredFont(type: .avantGardeITCTTDemi, size: 60)
      $0.textColor = .black0
      $0.text = title
    }
    subTitleLabel = UILabel().also {
      $0.font = .preferredFont(type: .avantGardeBook, size: 16)
      $0.textColor = .black0
      $0.text = subTitle
    }
  }
}

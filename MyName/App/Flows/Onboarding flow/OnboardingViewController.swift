//
//  OnboardingViewController.swift
//  MyName
//
//  Created by hb1love on 18/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class OnboardingViewController: UIViewController {

  // MARK: - Subviews

  @IBOutlet weak var onboardingContainer: UIView!
  @IBOutlet weak var skipButton: UIButton!

  // MARK: - Flow handler

  var onFinish: (() -> Void)?

  // MARK: - View Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: true)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: true)
  }

  @IBAction func skip(_ sender: UIButton) {
    self.onFinish?()
  }
}

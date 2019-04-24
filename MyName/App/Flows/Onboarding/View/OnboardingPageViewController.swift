//
//  OnboardingPageViewController.swift
//  MyName
//
//  Created by hb1love on 24/04/2019.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

final class OnboardingPageViewController: UIPageViewController {
  private enum Pages: String, CaseIterable {
    case onboardingFirst
    case onboardingSecond
    case onboardingThird
  }

  private lazy var orderedViewControllers: [UIViewController] = {
    return Pages.allCases.map { (storyboard?.instantiateViewController(withIdentifier: $0.rawValue))! }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.dataSource = self
    self.delegate = self

    if let firstVC = orderedViewControllers.first {
      setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
    }
  }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
    let previousIndex = viewControllerIndex - 1
    guard previousIndex >= 0 else { return orderedViewControllers.last }
    guard orderedViewControllers.count > previousIndex else { return nil }
    return orderedViewControllers[previousIndex]
  }

  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
    let nextIndex = viewControllerIndex + 1
    guard nextIndex < orderedViewControllers.count else { return orderedViewControllers.first }
    guard orderedViewControllers.count > nextIndex else { return nil }
    return orderedViewControllers[nextIndex]
  }

  func presentationCount(for: UIPageViewController) -> Int {
    return orderedViewControllers.count
  }

  func presentationIndex(for pageViewController: UIPageViewController) -> Int {
    return 0
  }
}

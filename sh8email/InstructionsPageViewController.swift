//
//  InstructionsViewController.swift
//  sh8email
//
//  Created by Hun Jae Lee on 1/5/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import UIKit

// Thanks, Jeff Burt! -@hunj
// Source: https://spin.atomicobject.com/2015/12/23/swift-uipageviewcontroller-tutorial/
class InstructionsPageViewController: UIPageViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
		self.dataSource = self
		
		if let firstViewController = orderedViewControllers.first {
			self.setViewControllers([firstViewController],
			                   direction: .forward,
			                   animated: true,
			                   completion: nil)
		}
	}
	
	private(set) lazy var orderedViewControllers: [UIViewController] = {
		return [self.newInstructionsViewController("1"),
		        self.newInstructionsViewController("2"),
		        self.newInstructionsViewController("3")]
	}()
	
	private func newInstructionsViewController(_ instruction_index: String) -> UIViewController {
		return UIStoryboard(name: "Main", bundle: nil) .
			instantiateViewController(withIdentifier: "Instructions\(instruction_index)")
	}
}

// MARK: UIPageViewControllerDataSource

extension InstructionsPageViewController: UIPageViewControllerDataSource {
	func pageViewController(_ pageViewController: UIPageViewController,
	                        viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
			return nil
		}
		
		let previousIndex = viewControllerIndex - 1
		
		guard previousIndex >= 0 else {
			return nil
		}
		
		guard orderedViewControllers.count > previousIndex else {
			return nil
		}
		
		return orderedViewControllers[previousIndex]

	}
	
	func pageViewController(_ pageViewController: UIPageViewController,
	                        viewControllerAfter viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
			return nil
		}
		
		let nextIndex = viewControllerIndex + 1
		let orderedViewControllersCount = orderedViewControllers.count
		
		guard orderedViewControllersCount != nextIndex else {
			return nil
		}
		
		guard orderedViewControllersCount > nextIndex else {
			return nil
		}
		
		return orderedViewControllers[nextIndex]
	}
	
}

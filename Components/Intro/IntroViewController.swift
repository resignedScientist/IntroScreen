//
//  IntroViewController.swift
//  IntroScreen
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit

open class IntroViewController: UIPageViewController {
    
    private let introDataSource: IntroDataSource
    private let saturation: CGFloat
    private let brightness: CGFloat
    
    private var startColor: CGFloat?
    private var targetColor: CGFloat?
    private var currentVC: IntroPageViewController?
    private var targetVC: IntroPageViewController?
    
    public init(dataSource: IntroDataSource, saturation: CGFloat = 0.85, brightness: CGFloat = 0.9) {
        self.introDataSource = dataSource
        self.saturation = saturation
        self.brightness = brightness
        
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
    }
    
    private lazy var pageControl: UIPageControl? = {
        for view in view.subviews {
            if let view = view as? UIPageControl {
                return view
            }
        }
        return nil
    }()
    
    private lazy var scrollView: UIScrollView? = {
        for view in self.view.subviews {
            if let view = view as? UIScrollView {
                return view
            }
        }
        return nil
    }()
    
    required public init?(coder: NSCoder) {
        fatalError("Initializing with coder is not supported.")
    }
}

// MARK: - Lifecycle

extension IntroViewController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        scrollView?.delegate = self
        
        if let startViewController = introDataSource.viewController(at: 0) {
            setViewControllers([startViewController], direction: .forward, animated: true)
            currentVC = startViewController
            self.view.backgroundColor = UIColor(
                hue: startViewController.hue,
                saturation: saturation,
                brightness: brightness, alpha: 1
            )
        }
    }
    
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let currentVC = currentVC else { return }
        
        if introDataSource.fadeOutLastPage && currentVC.index == introDataSource.numberOfPages - 1 {
            self.view.backgroundColor = UIColor.clear
        } else {
            self.view.backgroundColor = UIColor(
                hue: currentVC.hue,
                saturation: saturation,
                brightness: brightness,
                alpha: 1
            )
        }
    }
}

// MARK: - Color Transition

extension IntroViewController {
    
    private func changeColor(from startHue: CGFloat,
                     to targetHue: CGFloat,
                     scrolled: CGFloat) {
        let diff = targetHue - startHue
        let posDiff = diff < 0 ? diff * -1 : diff
        var hue: CGFloat
        if 1 - posDiff > posDiff { // shortest way is not over a color border (0 or 1)
            if diff > 0 { // start < target
                hue = diff * scrolled + startHue
            } else { // start > target
                hue = ((diff * scrolled * -1) - startHue) * -1
            }
        } else { // shortest way is over a color border (0 or 1)
            if diff > 0 { // start < target
                let total = startHue + 1 - targetHue
                hue = startHue - (total * scrolled)
                while hue < 0 {
                    hue += 1
                }
            } else { // start > target
                let total = 1 - startHue + targetHue
                hue = startHue + (total * scrolled)
                while hue > 1 {
                    hue -= 1
                }
            }
        }
        self.view.backgroundColor = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: 1
        )
    }
    
    private func fadeOut(hue: CGFloat, scrolled: CGFloat) {
        let alpha = 1 - scrolled
        self.view.backgroundColor = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: alpha
        )
    }
    
    private func fadeIn(hue: CGFloat, scrolled: CGFloat) {
        self.view.backgroundColor = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: scrolled
        )
    }
    
    private func getScrolledPercentage(for pixels: CGFloat) -> CGFloat {
        let width = view.frame.width
        let progressPixels = pixels - width
        return abs(progressPixels / width)
    }
}

// MARK: - Moving pages

extension IntroViewController {
    
    /// Move to the next page.
    public func nextPage() {
        guard let currentVC = currentVC else { return }
        guard let nextVC = pageViewController(self, viewControllerAfter: currentVC) as? IntroPageViewController else { return }
        
        pageViewController(self, willTransitionTo: [nextVC])
        setViewControllers([nextVC], direction: .forward, animated: true) { (completed) in
            self.scrollView?.setContentOffset(self.scrollView!.contentOffset, animated: true)
            self.pageViewController(
                self,
                didFinishAnimating: true,
                previousViewControllers: [currentVC],
                transitionCompleted: completed
            )
            if completed {
                self.pageControl?.currentPage = nextVC.index
            }
        }
    }
    
    /// Move to the previous page.
    public func previousPage() {
        guard let currentVC = currentVC else { return }
        guard let nextVC = pageViewController(self, viewControllerBefore: currentVC) as? IntroPageViewController else { return }
        pageViewController(self, willTransitionTo: [nextVC])
        setViewControllers([nextVC], direction: .reverse, animated: true) { (completed) in
            self.scrollView?.setContentOffset(self.scrollView!.contentOffset, animated: true)
            self.pageViewController(
                self,
                didFinishAnimating: true,
                previousViewControllers: [currentVC],
                transitionCompleted: completed
            )
            if completed {
                self.pageControl?.currentPage = nextVC.index
            }
        }
    }
}

// MARK: - UIPageViewControllerDelegate

extension IntroViewController: UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   willTransitionTo pendingViewControllers: [UIViewController]) {
        targetVC = pendingViewControllers[0] as? IntroPageViewController
        startColor = currentVC?.hue
        targetColor = targetVC?.hue
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool) {
        targetColor = nil
        if completed {
            currentVC = targetVC
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension IntroViewController: UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? IntroPageViewController else { return nil }
        
        let index = currentVC.index - 1
        return introDataSource.viewController(at: index)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                                   viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentVC = viewController as? IntroPageViewController else { return nil }
        
        let index = currentVC.index + 1
        return introDataSource.viewController(at: index)
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        introDataSource.numberOfPages
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        currentVC?.index ?? 0
    }
}

// MARK: - UIScrollViewDelegate

extension IntroViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard
            let startColor = self.startColor,
            let targetColor = self.targetColor
            else { return }
        
        let numberOfPages = introDataSource.numberOfPages
        let offset = scrollView.contentOffset
        let scrolled = getScrolledPercentage(for: offset.x)
        
        guard scrolled != 0 else {
            self.startColor = targetColor
            return
        }
        
        if (introDataSource.fadeOutLastPage) {
            // to last page -> alpha transition, fade out
            if currentVC?.index == numberOfPages - 2, targetVC?.index == numberOfPages - 1 {
                fadeOut(hue: startColor, scrolled: scrolled)
                return
            }
            
            // from last page -> alpha transition, fade in
            if currentVC?.index == numberOfPages - 1, targetVC?.index == numberOfPages - 2 {
                fadeIn(hue: targetColor, scrolled: scrolled)
                return
            }
        }
        
        // color transition
        changeColor(
            from: startColor,
            to: targetColor,
            scrolled: scrolled
        )
    }
}

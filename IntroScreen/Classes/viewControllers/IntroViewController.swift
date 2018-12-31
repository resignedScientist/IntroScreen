//
//  IntroViewController.swift
//  IntroScreen
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit

open class IntroViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    public var introDataSource: IntroDataSource?
    public var saturation: CGFloat = 0.85
    public var brightness: CGFloat = 0.9
    private var startColor: CGFloat?
    private var targetColor: CGFloat?
    private var currentVC: IntroPageViewController?
    private var targetVC: IntroPageViewController?
    private var pageControl: UIPageControl? {
        for view in view.subviews {
            if view is UIPageControl {
                return view as? UIPageControl
            }
        }
        return nil
    }
    private var scrollView: UIScrollView?
    
    required public init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        if let startViewController = introDataSource?.viewController(at: 0) {
            setViewControllers([startViewController], direction: .forward, animated: true, completion: nil)
            currentVC = startViewController
        }
        for view in self.view.subviews {
            if let view = view as? UIScrollView {
                view.delegate = self
                scrollView = view
                break
            }
        }
    }
    
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard
            let introDataSource = introDataSource,
            let currentVC = currentVC
            else { return }
        
        if introDataSource.fadeOutLastPage && currentVC.index == introDataSource.numberOfPages - 1 {
            self.view.backgroundColor = UIColor.clear
        } else {
            self.view.backgroundColor = UIColor(hue: currentVC.hue, saturation: saturation, brightness: brightness, alpha: 1)
        }
    }
    
    // MARK: - PageViewController
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentVC = viewController as? IntroPageViewController {
            let index = currentVC.index - 1
            return self.introDataSource?.viewController(at: index)
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentVC = viewController as? IntroPageViewController {
            let index = currentVC.index + 1
            return self.introDataSource?.viewController(at: index)
        }
        return nil
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        targetVC = pendingViewControllers[0] as? IntroPageViewController
        startColor = currentVC?.hue
        targetColor = targetVC?.hue
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        targetColor = nil
        if completed {
            currentVC = targetVC
        }
    }
    
    // MARK: - Page indicator
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return introDataSource?.numberOfPages ?? 0
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentVC?.index ?? 0
    }
    
    // MARK: - Scroll view
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard
            let introDataSource = introDataSource,
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
    
    // MARK: - Color Transition
    
    func changeColor(from startHue: CGFloat, to targetHue: CGFloat, scrolled: CGFloat) {
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
    
    func fadeOut(hue: CGFloat, scrolled: CGFloat) {
        let alpha = 1 - scrolled
        self.view.backgroundColor = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: alpha
        )
    }
    
    func fadeIn(hue: CGFloat, scrolled: CGFloat) {
        self.view.backgroundColor = UIColor(
            hue: hue,
            saturation: saturation,
            brightness: brightness,
            alpha: scrolled
        )
    }
    
    func getScrolledPercentage(for pixels: CGFloat) -> CGFloat {
        let width = view.frame.width
        let progressPixels = pixels - width
        return abs(progressPixels / width)
    }
    
    // MARK: - Moving pages
    
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

public protocol IntroDataSource {
    var numberOfPages: Int { get }
    var fadeOutLastPage: Bool { get }
    
    func viewController(at index: Int) -> IntroPageViewController?
}

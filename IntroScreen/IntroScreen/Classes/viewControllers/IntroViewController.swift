//
//  IntroViewController.swift
//  IntroScreen
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit

public class IntroViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate {
    public var introDataSource: IntroDataSource?
    public var saturation: CGFloat = 0.85
    public var brightness: CGFloat = 0.9
    private var startColor: CGFloat?
    private var targetColor: CGFloat?
    private var currentVC: IntroPageViewController?
    private var targetVC: IntroPageViewController?
    
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
                break
            }
        }
    }
    
    override open func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let introDataSource = introDataSource, let currentVC = currentVC else {
            return
        }
        if currentVC.index == introDataSource.numberOfPages - 1 {
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
        guard let introDataSource = introDataSource, let startColor = self.startColor, let targetColor = self.targetColor else {
            return
        }
        
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
        let hueDiff = targetHue - startHue
        let hue = (hueDiff * scrolled) + startHue
        self.view.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
    func fadeOut(hue: CGFloat, scrolled: CGFloat) {
        let alpha = 1 - scrolled
        self.view.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    func fadeIn(hue: CGFloat, scrolled: CGFloat) {
        self.view.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: scrolled)
    }
    
    func getScrolledPercentage(for pixels: CGFloat) -> CGFloat {
        let width = view.frame.width
        let progressPixels = pixels - width
        return abs(progressPixels / width)
    }
}

public protocol IntroDataSource {
    var numberOfPages: Int { get }
    var fadeOutLastPage: Bool { get }
    
    func viewController(at index: Int) -> IntroPageViewController?
}

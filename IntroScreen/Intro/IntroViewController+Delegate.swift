//
//  IntroViewController+UIPageViewControllerDelegate.swift
//  IntroScreen
//
//  Created by Norman Laudien on 17.04.20.
//

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

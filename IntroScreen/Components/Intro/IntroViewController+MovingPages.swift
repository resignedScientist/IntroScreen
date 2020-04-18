//
//  IntroViewController+MovingPages.swift
//  IntroScreen
//
//  Created by Norman Laudien on 17.04.20.
//

public extension IntroViewController {
    
    /// Move to the next page.
    func nextPage() {
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
    func previousPage() {
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

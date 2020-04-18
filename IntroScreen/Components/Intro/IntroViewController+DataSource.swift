//
//  IntroViewController+DataSource.swift
//  IntroScreen
//
//  Created by Norman Laudien on 17.04.20.
//

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

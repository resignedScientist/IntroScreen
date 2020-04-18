//
//  IntroViewController+Lifecycle.swift
//  IntroScreen
//
//  Created by Norman Laudien on 17.04.20.
//

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

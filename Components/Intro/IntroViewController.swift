//
//  IntroViewController.swift
//  IntroScreen
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit

open class IntroViewController: UIPageViewController {
    
    let introDataSource: IntroDataSource
    let saturation: CGFloat
    let brightness: CGFloat
    
    var startColor: CGFloat?
    var targetColor: CGFloat?
    var currentVC: IntroPageViewController?
    var targetVC: IntroPageViewController?
    
    public init(dataSource: IntroDataSource, saturation: CGFloat = 0.85, brightness: CGFloat = 0.9) {
        self.introDataSource = dataSource
        self.saturation = saturation
        self.brightness = brightness
        
        super.init(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal
        )
    }
    
    required public init?(coder: NSCoder) {
        fatalError("Initializing with coder is not supported.")
    }
    
    lazy var pageControl: UIPageControl? = {
        for view in view.subviews {
            if let view = view as? UIPageControl {
                return view
            }
        }
        return nil
    }()
    
    lazy var scrollView: UIScrollView? = {
        for view in self.view.subviews {
            if let view = view as? UIScrollView {
                return view
            }
        }
        return nil
    }()
}

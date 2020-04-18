//
//  BasicIntroPageVC.swift
//  IntroScreen
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

public typealias IntroPageViewController = UIViewController & IntroPage

public protocol IntroPage: AnyObject {
    
    /// The page index of this intro page.
    var index: Int { get }
    
    /// The color hue between 0 & 1 for the HSV color.
    var hue: CGFloat { get }
}

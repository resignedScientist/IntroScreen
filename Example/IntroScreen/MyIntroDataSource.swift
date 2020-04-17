//
//  ViewController.swift
//  IntroExample
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit
import IntroScreen

struct MyIntroDataSource: IntroDataSource {
    
    let numberOfPages = 3
    
    let fadeOutLastPage: Bool = false
    
    func viewController(at index: Int) -> IntroPageViewController? {
        switch index {
        case 0:
            return DefaultIntroPageViewController.getInstance(
                index: index,
                hue: 30/360,
                title: "First page",
                subtitle: "This is the first page.",
                image: UIImage(named: "first")
            )
        case 1:
            return DefaultIntroPageViewController.getInstance(
                index: index,
                hue: 60/360,
                title: "Second page",
                subtitle: "This is the second page.",
                image: UIImage(named: "second")
            )
        case 2:
            return DefaultIntroPageViewController.getInstance(
                index: index,
                hue: 90/360,
                title: "Third page",
                subtitle: "This is the third page.",
                image: UIImage(named: "third")
            )
        default:
            return nil
        }
    }
}

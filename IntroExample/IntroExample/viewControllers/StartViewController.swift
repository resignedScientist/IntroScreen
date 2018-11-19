//
//  ViewController.swift
//  IntroExample
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit
import IntroScreen

class StartViewController: UIViewController {
    
    @IBAction func startIntroTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "introSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "introSegue":
            let destination = segue.destination as! IntroViewController
            destination.introDataSource = self
        default:
            break
        }
    }
}

extension StartViewController: IntroDataSource {
    var numberOfPages: Int {
        return 3
    }
    
    var fadeOutLastPage: Bool {
        return false
    }
    
    func viewController(at index: Int) -> IntroPageViewController? {
        switch index {
        case 0:
            return DefaultIntroPageViewController.getInstance(
                index: index,
                hue: 30/360,
                title: "First page",
                subtitle: "This is the first page.",
                image: nil
            )
        case 1:
            return DefaultIntroPageViewController.getInstance(
                index: index,
                hue: 60/360,
                title: "Second page",
                subtitle: "This is the second page.",
                image: nil
            )
        case 2:
            return DefaultIntroPageViewController.getInstance(
                index: index,
                hue: 90/360,
                title: "Third page",
                subtitle: "This is the third page.",
                image: nil
            )
        default:
            return nil
        }
    }
}

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
            destination.modalPresentationStyle = .fullScreen
            destination.introDataSource = self
        default:
            break
        }
    }
}

// MARK: - Intro data source

extension StartViewController: IntroDataSource {
    
    var numberOfPages: Int { 3 }
    
    var fadeOutLastPage: Bool { false }
    
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

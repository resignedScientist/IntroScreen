//
//  AppDelegate.swift
//  IntroExample
//
//  Created by Norman Laudien on 19.11.18.
//  Copyright © 2018 Norman Laudien. All rights reserved.
//

import UIKit
import IntroScreen

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let dataSource = MyIntroDataSource()
        let viewController = IntroViewController(dataSource: dataSource)
        
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}


//
//  AppDelegate.swift
//  StickyCellsExample
//
//  Created by Maxime Tenth on 9/10/20.
//  Copyright © 2020 Mothxim. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let vc = ViewController(nibName: nil, bundle: nil)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
        return true
    }


}


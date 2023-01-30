//
//  AppDelegate.swift
//  ExchangeApp
//
//  Created by Abhishek Verma on 30/01/23.
//  Copyright © 2023 JMD. All rights reserved.
//

import UIKit

#warning("Optimization is required in the next sprint.")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let appModule = SelectionRouter.createModule()
        let navigationController = UINavigationController.init(rootViewController: appModule)
        navigationController.setNavigationBarTransperent()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}


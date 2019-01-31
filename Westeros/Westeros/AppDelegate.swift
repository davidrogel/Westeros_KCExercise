//
//  AppDelegate.swift
//  Westeros
//
//  Created by david rogel pernas on 31/01/2019.
//  Copyright © 2019 david rogel pernas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds) // creamos la ventana
        window?.makeKeyAndVisible()
        window?.backgroundColor = .red
        
        let rootViewController = UIViewController()
        
        window?.rootViewController = rootViewController
        // Override point for customization after application launch.
        return true
    }
}


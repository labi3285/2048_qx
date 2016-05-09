//
//  AppDelegate.swift
//  2048_qx
//
//  Created by Richard.q.x on 16/5/3.
//  Copyright © 2016年 labi3285_lab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow();
        
        let mainVc = MainViewController()
        window?.rootViewController = mainVc
        window?.makeKeyAndVisible()
        
        return true
    }
}


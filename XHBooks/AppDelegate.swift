//
//  AppDelegate.swift
//  XHBooks
//
//  Created by 李丝思 on 16/4/18.
//  Copyright © 2016年 思. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        /**
         设置leanCloud
         */
        AVOSCloud.setApplicationId("kwQNDB18i0aUokGzA1tYMu67-gzGzoHsz", clientKey: "K5DMAsKnC4bUGUJXBpFM5J4D")
        
        self.window = UIWindow(frame: CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT))
        let tarbarController = UITabBarController()
        let rankView = UINavigationController(rootViewController: rankViewController())
        let searchView = UINavigationController(rootViewController: searchViewController())
        let pushView = UINavigationController(rootViewController: pushViewController())
        let circleView = UINavigationController(rootViewController: circleViewController())
        let moreView = UINavigationController(rootViewController: moreViewController())
        tarbarController.viewControllers=[rankView,searchView,pushView,circleView,moreView]
        
        let tabbarItem1 = UITabBarItem(title: "排行榜", image: UIImage(named: "sort_no"), selectedImage: UIImage(named: "sort_select"))
        let tabbarItem2 = UITabBarItem(title: "发现", image: UIImage(named: "new"), selectedImage: UIImage(named: "new"))
        let tabbarItem3 = UITabBarItem(title: "", image: UIImage(named: "write"), selectedImage: UIImage(named: "write"))
        let tabbarItem4 = UITabBarItem(title: "圈子", image: UIImage(named: "round_no"), selectedImage: UIImage(named: "round_select"))
        let tabbarItem5 = UITabBarItem(title: "更多", image: UIImage(named: "more_select"), selectedImage: UIImage(named: "more_select"))
        rankView.tabBarItem=tabbarItem1
        searchView.tabBarItem=tabbarItem2
        pushView.tabBarItem=tabbarItem3
        circleView.tabBarItem=tabbarItem4
        moreView.tabBarItem=tabbarItem5
        rankView.tabBarController?.tabBar.tintColor = MAIN_RED
        self.window?.rootViewController=tarbarController
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


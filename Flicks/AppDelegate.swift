//
//  AppDelegate.swift
//  Flicks
//
//  Created by nguyen trung quang on 3/11/16.
//  Copyright © 2016 coderSchool. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let tabbar = UITabBarController()
        tabbar.tabBar.barTintColor = UIColor(colorLiteralRed: 240.0/255.0, green: 187.0/255.0, blue: 90.0/255.0, alpha: 0.8)
        let nowPlaying = UINavigationController(rootViewController: NowPlayingTableViewController())
        nowPlaying.tabBarItem = UITabBarItem(title:"NowPlaying", image:UIImage(named: "nowplaying"), selectedImage:nil)
        let topRated = UINavigationController(rootViewController: TopRatedTableViewController())
        topRated.tabBarItem = UITabBarItem(title:"TopRated", image: UIImage(named: "Rating"), selectedImage:nil)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //note
        if let window = self.window {
            tabbar.viewControllers = [nowPlaying ,topRated]
            window.rootViewController = tabbar
        }
        self.window?.backgroundColor = UIColor.blackColor()
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


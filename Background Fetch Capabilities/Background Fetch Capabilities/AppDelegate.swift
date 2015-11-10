//
//  AppDelegate.swift
//  Background Fetch Capabilities
//
//  Created by Guy Azran on 11/9/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var newsItems = [NewsItem]();


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        newsItems.append(NewsItem(date: NSDate(), text: "News Item \(newsItems.count)"));
        
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum);
        
        return true
    }
    
    class func newsItemsChangedNotification() ->String { // this is the same as: static let newsItemsChangedNotification = "newsItemsChangedNotification";
        return "\(__FUNCTION__)"; //__FUNCTION__ is a string that holds the name of the function you are in
    }
    
    func fetchNewsItems() ->Bool{ //this method will fetch data (news item) from a server
        
        newsItems.insert(NewsItem(date: NSDate(), text: "News Item \(newsItems.count)"), atIndex: 0);
        
        NSNotificationCenter.defaultCenter().postNotificationName(AppDelegate.newsItemsChangedNotification(), object: nil);
        
        
        return true;
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        if fetchNewsItems(){
            completionHandler(.NewData);
        } else{
            completionHandler(.NoData);
        }
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


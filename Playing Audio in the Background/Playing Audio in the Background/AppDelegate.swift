//
//  AppDelegate.swift
//  Playing Audio in the Background
//
//  Created by Guy Azran on 11/12/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import AVFoundation;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AVAudioPlayerDelegate {

    var window: UIWindow?
    var audioPlayer: AVAudioPlayer!;

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue) { [weak self]() -> Void in
            let audioSession = AVAudioSession.sharedInstance();
            NSNotificationCenter.defaultCenter().addObserver(self!, selector: "handleInterruption", name: AVAudioSessionInterruptionNotification, object: nil);
            
            do{
                try audioSession.setActive(true);
                try audioSession.setCategory(AVAudioSessionCategoryPlayback);
                print("successfully set the audio seddion");
            } catch{
                print("error occured. couldn't set the audio sesson");
            }
            
            let filePath = NSBundle.mainBundle().pathForResource("zohan", ofType: "mp3");
            do{
                let fileData = try NSData(contentsOfFile: filePath!, options: NSDataReadingOptions.DataReadingMappedIfSafe);
                
                self!.audioPlayer = try AVAudioPlayer(data: fileData);
                self!.audioPlayer.delegate = self;
                if self!.audioPlayer.prepareToPlay() && self!.audioPlayer.play(){
                    print("successfully started playing");
                } else{
                    print("failed to play");
                }
            } catch{
                
            }
            

        }
        
        return true
    }
    
    func handleInterruption(notification: NSNotification){
        let interruptionTypeAsObject = notification.userInfo![AVAudioSessionInterruptionTypeKey] as! NSNumber;
        let interruptionType = AVAudioSessionInterruptionType(rawValue: interruptionTypeAsObject.unsignedLongValue);
        
        if let type = interruptionType{
            if type == AVAudioSessionInterruptionType.Ended{
                //resum the audio if needed
            }
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


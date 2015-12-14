//
//  ViewController.swift
//  Using the Accelerometer
//
//  Created by Guy Azran on 12/14/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    lazy var motionManager = CMMotionManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check for accelerometer
        if motionManager.accelerometerAvailable{
            print("accelerometer is available");
            let queue = NSOperationQueue();
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler: { (data, error) -> Void in
                //print("X:\(data!.acceleration.x)  Y:\(data!.acceleration.y)  Z:\(data!.acceleration.z)");
            })
        } else{
            print("accelerometer is NOT available")
        }
        if motionManager.accelerometerActive{
            print("accelerometer is active");
        } else{
            print("accelerometer is NOT active");
        }
        
        //check for gyroscope
        if motionManager.gyroAvailable{
            print("gyroscope is available");
            if motionManager.gyroActive == false{
                motionManager.gyroUpdateInterval = 1.0 / 4.0;
                let queue = NSOperationQueue();
                motionManager.startGyroUpdatesToQueue(queue, withHandler: { (data, error) -> Void in
                    print("X:\(data!.rotationRate.x)  Y:\(data!.rotationRate.y)  Z:\(data!.rotationRate.z)");
                });
            }
        } else{
            print("gyroscope is NOT available")
        }
        if motionManager.gyroActive{
            print("gyroscope is active");
        } else{
            print("gyroscope is NOT active");
        }
    }
    
    //this method belongs to UIResponder. it can be used to detect shakes and other events such as remote control functions
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            print("shake start");
        }
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake{
            print("shake end");
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


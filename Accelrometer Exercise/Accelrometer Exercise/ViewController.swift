//
//  ViewController.swift
//  Accelrometer Exercise
//
//  Created by Guy Azran on 12/14/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var motionManager: CMMotionManager!;
    var squareView: UIView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50));
        squareView.center = view.center;
        squareView.backgroundColor = UIColor.greenColor();
        view.addSubview(squareView);
        
        motionManager = CMMotionManager();
        if motionManager.accelerometerAvailable{
            let queue = NSOperationQueue();
            motionManager.startAccelerometerUpdatesToQueue(queue, withHandler: { [weak self](data, error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self!.squareView.frame.origin.x += CGFloat(10 * data!.acceleration.x);
                    self!.squareView.frame.origin.y += CGFloat(-10 * data!.acceleration.y);
                    //add collision
                })
                
            })
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


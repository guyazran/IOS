//
//  ViewController.swift
//  Gesture Recognizer
//
//  Created by Guy Azran on 11/16/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //swipe
    var swipeRecognizer: UISwipeGestureRecognizer!;
    
    //rotation
    var label: UILabel!;
    var rotationRecognizer: UIRotationGestureRecognizer!;
    var rotationAngleInRadians: CGFloat = 0.0;
    
    //pan
    var panRecognizer: UIPanGestureRecognizer!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //swipe
        /*
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipes:");
        swipeRecognizer.direction = [.Left, .Right]; //a gesture recognizer can only detect one kind of swipe (or array of swipes)
        swipeRecognizer.numberOfTouchesRequired = 1;
        view.addGestureRecognizer(swipeRecognizer);
        */

        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30));
        label.text = "Hello World";
        label.textAlignment = .Center;
        label.backgroundColor = UIColor.lightGrayColor();
        label.font = UIFont.systemFontOfSize(16);
        label.sizeToFit();
        label.center = view.center;
        view.addSubview(label);
        
        //rotation
        rotationRecognizer = UIRotationGestureRecognizer(target: self, action: "handleRotation:");
        view.addGestureRecognizer(rotationRecognizer);
        
        //pan
        panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:");
        panRecognizer.minimumNumberOfTouches = 1;
        panRecognizer.maximumNumberOfTouches = 1;
        label.userInteractionEnabled = true;
        label.addGestureRecognizer(panRecognizer);
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        //1 swipe recognizer
        print("sipe");
        
        /*
        //multiple swipe recognizers leading to the same method
        switch sender.direction{ //direction is the direction initialized in the sender
        case UISwipeGestureRecognizerDirection.Down:
            print("down");
        case UISwipeGestureRecognizerDirection.Up:
            print("up");
        case UISwipeGestureRecognizerDirection.Left:
            print("left")
        case UISwipeGestureRecognizerDirection.Right:
            print("right");
        default:
            print("what?");
        }
        */
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer){

        label.transform = CGAffineTransformMakeRotation(rotationAngleInRadians + sender.rotation);
        
        if sender.state == .Ended{ //the angle field will only be updated when the user releases the touching fingers from the screen.
            rotationAngleInRadians += sender.rotation;
        }
    }
    
    func handlePan(sender: UIPanGestureRecognizer){
        print("in pan");
        if sender.state != .Ended && sender.state != .Failed{
            let location = sender.locationInView(sender.view!.superview!);
            sender.view!.center = location;
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
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
    
    //long press
    var longPressRecognizer: UILongPressGestureRecognizer!;
    
    //tap
    var tapRecognizer: UITapGestureRecognizer!;
    
    //pinch
    var pinchRecognizer: UIPinchGestureRecognizer!;
    var currentScale:CGFloat = 0.0;
    
    //screen edge pan
    var screenEdgePanRecognizer: UIScreenEdgePanGestureRecognizer!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //swipe
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipes:");
        swipeRecognizer.direction = [.Left, .Right]; //a gesture recognizer can only detect one kind of swipe (or array of swipes)
        swipeRecognizer.numberOfTouchesRequired = 1;
        view.addGestureRecognizer(swipeRecognizer);
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100));
        label.text = "Hello World";
        label.textAlignment = .Center;
        label.backgroundColor = UIColor.lightGrayColor();
        label.font = UIFont.systemFontOfSize(16);
        //label.sizeToFit();
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
        
        //long press
        longPressRecognizer = UILongPressGestureRecognizer(target: self, action: "handleLongPress:");
        //the number of fingers that must touch the screen in order for the recognizer to invoke it's action
        longPressRecognizer.numberOfTouchesRequired = 2;
        //maximum movement (in pixels) allowed during the long press before the action is invoked
        longPressRecognizer.allowableMovement = 100;
        //how long the user must press the view in for the function to work
        longPressRecognizer.minimumPressDuration = 1;
        view.addGestureRecognizer(longPressRecognizer);
        
        //tap
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:");
        tapRecognizer.numberOfTouchesRequired = 2;
        tapRecognizer.numberOfTapsRequired = 3;
        view.addGestureRecognizer(tapRecognizer);
        
        //pinch
        pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "handlePinch:");
        label.addGestureRecognizer(pinchRecognizer);
        
        //screen edge pan
        screenEdgePanRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: "handleScreenEdgePan:");
        screenEdgePanRecognizer.edges = .Left;
        view.addGestureRecognizer(screenEdgePanRecognizer);
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
        //1 swipe recognizer
        print("swipe");
        
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
    
    func handleLongPress(sender: UILongPressGestureRecognizer){
        if sender.numberOfTouches() == 2{
            let touchPoint1 = sender.locationOfTouch(0, inView: sender.view);
            let touchPoint2 = sender.locationOfTouch(1, inView: sender.view);
            
            let midPointX = (touchPoint1.x + touchPoint2.x) / 2.0;
            let midPointy = (touchPoint1.y + touchPoint2.y) / 2.0;
            
            let midPoint = CGPoint(x: midPointX, y: midPointy);
            
            label.center = midPoint;
        }
        
    }
    
    func handleTap(sender: UITapGestureRecognizer){
        for touchcCounter in 0..<sender.numberOfTouchesRequired{
            let touchPoint = sender.locationOfTouch(touchcCounter, inView: sender.view);
            print("Touch \(touchcCounter + 1): \(touchPoint)");
        }
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer){
        print("pinch");
        if sender.state == .Ended{
            currentScale = sender.scale;
        } else if sender.state == .Began && currentScale != 0.0{
            sender.scale = currentScale;
        }
        
        if sender.scale != CGFloat.NaN && sender.scale != 0.0{
            sender.view!.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
        }
    }
    
    func handleScreenEdgePan(sender: UIScreenEdgePanGestureRecognizer){
        if sender.state == .Ended{
            print("edge touched");
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
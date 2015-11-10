//
//  ViewController.swift
//  Bouncing Ball Exercise
//
//  Created by Guy Azran on 11/9/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var go = false;
    
    var bouncers = [Bouncer]();
    
    var btnAnimateSquare: UIButton!;
    var btnNewBouncer: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnAnimateSquare = UIButton(type: .System);
        btnAnimateSquare.frame = CGRect(x: 0, y: 20, width: 50, height: 35);
        btnAnimateSquare.center.x = view.center.x;
        btnAnimateSquare.setTitle("Start", forState: .Normal);
        btnAnimateSquare.addTarget(self, action: "animateSquare:", forControlEvents: .TouchUpInside);
        view.addSubview(btnAnimateSquare);
        
        btnNewBouncer = UIButton(type: .Custom);
        btnNewBouncer.frame = CGRect(x: 0, y: view.frame.height - 35, width: view.frame.width, height: 35);
        btnNewBouncer.center.x = view.center.x;
        btnNewBouncer.setTitle("New Ball", forState: .Normal);
        btnNewBouncer.setBackgroundImage(UIImage(named: "grey_button"), forState: .Normal);
        btnNewBouncer.setTitleColor(UIColor.whiteColor(), forState: .Normal);
        btnNewBouncer.addTarget(self, action: "newSquare:", forControlEvents: .TouchUpInside);
        view.addSubview(btnNewBouncer);
    }

    func doAtInterval(delayInSeconds: Double, action: () -> Void){
        
        let delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        
        if go{
            dispatch_after(delayInNanoSeconds, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { [weak self] () -> Void in //code executed in dispatch_after is executed in a global thread
                action();
                self!.doAtInterval(delayInSeconds, action: action)
            }
        }
    }
    
    func newSquare(sender: UIButton){
        let maxX:UInt32 = UInt32(view.frame.width) + 1 - 30;
        var newX = CGFloat(arc4random_uniform(maxX));
        
        let maxY:UInt32 = UInt32(view.frame.height) - 30 - UInt32(btnNewBouncer.frame.height);
        var newY = CGFloat(arc4random_uniform(maxY));
        
        if newX == 0{
            newX = 1;
        }
        if newY == 0{
            newY = 1;
        }
        
        var newVelocityX = CGFloat(arc4random_uniform(100)) / 100.0;
        var newVelocityY = CGFloat(arc4random_uniform(100)) / 100.0;
        
        
        let isNegativeX = Int(arc4random_uniform(1));
        let isNegativeY = Int(arc4random_uniform(1));
        
        if isNegativeX == 1{
            newVelocityX *= -1;
        }
        if isNegativeY == 1{
            newVelocityY *= 1;
        }
        
        let newColor = Int(arc4random_uniform(7));
        
        let newBouncer = Bouncer(x: newX, y: newY, velocityX: newVelocityX, velocityY: newVelocityY, color: newColor);
        bouncers.append(newBouncer);
        view.addSubview(newBouncer.squareView);
    }
    
    func animateSquare(sender: UIButton){
        go = true;
        doAtInterval(0.001) { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
                for bouncer in self!.bouncers{
                    let boundries = CGRect(x: self!.view.frame.origin.x, y: self!.view.frame.origin.y, width: self!.view.frame.width, height: self!.view.frame.height - self!.btnNewBouncer.frame.height);
                    bouncer.checkBounceOffFrame(boundries);
                    bouncer.move();
                }
                
            });
        }
        btnAnimateSquare.removeTarget(self, action: "animateSquare:", forControlEvents: .TouchUpInside);
        btnAnimateSquare.addTarget(self, action: "stopAnimation:", forControlEvents: .TouchUpInside);
        btnAnimateSquare.setTitle("Stop", forState: .Normal);
    }
    
    func stopAnimation(sender: UIButton){
        go = false
        btnAnimateSquare.removeTarget(self, action: "stopAnimation:", forControlEvents: .TouchUpInside);
        btnAnimateSquare.addTarget(self, action: "animateSquare:", forControlEvents: .TouchUpInside);
        btnAnimateSquare.setTitle("Start", forState: .Normal);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


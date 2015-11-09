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
    
    var squareView: UIView!;
    var velocityX:CGFloat = 1;
    var velocityY:CGFloat = 1;
    
    var btnAnimateSquare: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50));
        squareView.center = view.center;
        squareView.backgroundColor = UIColor.greenColor();
        view.addSubview(squareView);
        
        
        
        btnAnimateSquare = UIButton(type: .System);
        btnAnimateSquare.frame = CGRect(x: view.center.x - 25, y: 20, width: 50, height: 35);
        btnAnimateSquare.setTitle("Start", forState: .Normal);
        btnAnimateSquare.addTarget(self, action: "animateSquare:", forControlEvents: .TouchUpInside);
        view.addSubview(btnAnimateSquare);
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
    
    func animateSquare(sender: UIButton){
        go = true;
        doAtInterval(0.001) { () -> Void in
            dispatch_async(dispatch_get_main_queue(), { [weak self] () -> Void in
                if(self!.squareView.center.y + 25 >= self!.view.frame.maxY) || (self!.squareView.center.y - 25 <= self!.view.frame.origin.y){
                    self!.velocityY *= -1;
                }
                self!.squareView.frame.origin.y += self!.velocityY;
                
                if(self!.squareView.center.x + 25 >= self!.view.frame.maxX) || (self!.squareView.center.x - 25 <= self!.view.frame.origin.x){
                    self!.velocityX *= -1;
                }
                self!.squareView.frame.origin.x += self!.velocityX;
                
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


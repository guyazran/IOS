//
//  ViewController.swift
//  Dispatch After (Delay)
//
//  Created by Guy Azran on 11/9/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!;
    
    var go:Bool = true;
    var btnDo: UIButton!;
    var btnStop: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100));
        label.center = view.center;
        label.textAlignment = .Center;
        label.text = "this is text";
        view.addSubview(label);
        
        btnDo = UIButton(type: .System);
        btnDo.frame = CGRect(x: view.center.x - 50, y: label.frame.maxY, width: 100, height: 35);
        btnDo.setTitle("start intervals", forState: UIControlState.Normal);
        btnDo.addTarget(self, action: "btnDo:", forControlEvents: .TouchUpInside);
        view.addSubview(btnDo);
        
        btnStop = UIButton(type: .System);
        btnStop.frame = CGRect(x: view.center.x - 50, y: btnDo.frame.maxY, width: 100, height: 35);
        btnStop.setTitle("stop intervals", forState: UIControlState.Normal);
        btnStop.addTarget(self, action: "btnStop:", forControlEvents: .TouchUpInside);
        view.addSubview(btnStop);
        
        let delayInSeconds = 5.0;
        
        let delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        print("start");
        dispatch_after(delayInNanoSeconds, queue) { [weak self] () -> Void in //code executed in dispatch_after is executed in a global thread
            print(".");
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self!.label.text = "text changed";
            })
            
        }
        
        
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
    
    func btnDo(sender: UIButton){
        go = true;
        doAtInterval(5.0) { () -> Void in
            print("interval reached");
        }
    }

    func btnStop(sender: UIButton){
        go = false;
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


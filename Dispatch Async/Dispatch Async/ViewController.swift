//
//  ViewController.swift
//  Dispatch Async
//
//  Created by Guy Azran on 11/9/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!;

    override func viewDidLoad() {
        super.viewDidLoad()

        //GCD - Grand Central Dispatch
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30));
        label.center = view.center;
        label.textAlignment = .Center;
        label.text = "some text...";
        view.addSubview(label);
        
        print("Current Thread = \(NSThread.currentThread())"); //returns the current thread this code is running in
        print("Current Thread = \(NSThread.mainThread())"); //returns the main thread
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            print("Current Thread = \(NSThread.currentThread())");
            print("Current Thread = \(NSThread.mainThread())");
            var sum = 0;
            for _ in 0..<100000{
                sum++;
                print(sum);
            }
            
            dispatch_async(dispatch_get_main_queue()) { [weak self] () -> Void in
                self!.label.text = "done";
            }
        }
        
        //let's assume that this code is invoked from a global thread (not the main thread)
        //modifying the UI from a global thread is prohibited
        dispatch_async(dispatch_get_main_queue()) { [weak self] () -> Void in
            self!.label.text = "text changed";
        }
        
        
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


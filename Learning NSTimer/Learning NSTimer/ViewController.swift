//
//  ViewController.swift
//  Learning NSTimer
//
//  Created by Guy Azran on 11/9/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var counter = 0;
    
    var timer:NSTimer!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in viewDidLoad");
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "whatToDo:", userInfo: nil, repeats: true);
    }
    
    func whatToDo(timer: NSTimer){
        print("do something... \(++counter)");
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        print("in viewDidAppear");
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
        print("in viewDIdDisappear");
    }
    
    deinit{
        timer.invalidate(); //stops the timer
        timer = nil; //make the garbage collector collect the timer object
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


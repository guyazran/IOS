//
//  ViewController.swift
//  Learning NSTimer
//
//  Created by Guy Azran on 11/9/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in viewDidLoad");
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        print("in viewDidAppear");
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
        print("in viewDIdDisappear");
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


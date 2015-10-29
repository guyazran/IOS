//
//  ViewController2.swift
//  Multiple View Controllers
//
//  Created by Guy Azran on 10/29/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        view.backgroundColor = UIColor.whiteColor();
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30));
        label.text = "View Controller 2";
        label.center = view.center;
        label.textAlignment = .Center;
        view.addSubview(label);
        
        let button = UIButton(type: UIButtonType.System);
        button.frame = CGRect(x: (view.frame.width - 200) / 2, y: label.frame.maxY, width: 200, height: 20);
        button.setTitle("Go To View Controller 1", forState: UIControlState.Normal);
        button.addTarget(self, action: "handleClick:", forControlEvents: UIControlEvents.TouchUpInside);
        
        view.addSubview(button);
        print("in viewDidLoad of viewController2");
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        let viewController1 = presentingViewController as! ViewController;
        viewController1.stam();
        print("in viewDidAppear of viewController2");
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
        print("in viewDidDisappear of viewController2");
    }
    
    
    
    func handleClick(sender: UIButton){
        dismissViewControllerAnimated(true, completion: nil);
    }
}
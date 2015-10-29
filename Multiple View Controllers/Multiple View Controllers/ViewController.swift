//
//  ViewController.swift
//  Multiple View Controllers
//
//  Created by Guy Azran on 10/29/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let viewController2 = ViewController2();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30));
        label.text = "View Controller 1";
        label.center = view.center;
        label.textAlignment = .Center;
        view.addSubview(label);
        
        let button = UIButton(type: UIButtonType.System);
        button.frame = CGRect(x: (view.frame.width - 200) / 2, y: label.frame.maxY, width: 200, height: 20);
        button.setTitle("Go To View Controller 2", forState: UIControlState.Normal);
        button.addTarget(self, action: "handleClick:", forControlEvents: UIControlEvents.TouchUpInside);

        view.addSubview(button);
        print("in viewDidLoad of viewController1");
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        print("in viewDidAppear of viewController1");
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated);
        print("in viewDidDisappear of viewController1");

    }

    func handleClick(sender: UIButton){
        presentViewController(viewController2, animated: true, completion: nil);
    }
    
    func stam(){
        print("stam");
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


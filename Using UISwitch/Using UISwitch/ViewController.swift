//
//  ViewController.swift
//  Using UISwitch
//
//  Created by Guy Azran on 10/22/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var mainSwitch: UISwitch!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainSwitch = UISwitch(frame: CGRect(x: 100, y: 100, width: 0, height: 0));
        
        
        view.addSubview(mainSwitch);
        
        mainSwitch.addTarget(self, action: "switchIsChanged:", forControlEvents: UIControlEvents.ValueChanged);
        mainSwitch.tintColor = UIColor.redColor(); //off-mode tint color;
        mainSwitch.onTintColor = UIColor(red: 0, green: 0, blue: 1, alpha: 1); //on-mode tint color;
        mainSwitch.thumbTintColor = UIColor.purpleColor(); //change the circle color
    }
    
    func switchIsChanged(sender: UISwitch){
        print("the value of the switch was changed to \(sender.on)");
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        mainSwitch.setOn(true, animated: true);
        
        if mainSwitch.on{
            /* switch is on */
        } else{
            /* switch is off */
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


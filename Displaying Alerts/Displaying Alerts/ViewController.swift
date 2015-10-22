//
//  ViewController.swift
//  Displaying Alerts
//
//  Created by Guy Azran on 10/22/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var controller:UIAlertController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = UIAlertController(title: "Warning", message: "Battery Low!", preferredStyle: UIAlertControllerStyle.Alert);
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            print("the OK button was tapped");
        }
        
        controller?.addAction(action);
        
        controller?.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "XXXXXXXXXXXX";
        })
        
        let actionNext = UIAlertAction(title: "Next", style: .Default) { [weak self](action: UIAlertAction) -> Void in
            
            if let textfields = self!.controller!.textFields{
                let username = textfields[0].text;
                
                if let theUsername = username{
                    if (theUsername as! NSString).length > 3{
                        print("your username is " + theUsername);
                    }
                }
            }
        }
        
        controller?.addAction(actionNext)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        presentViewController(controller!, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


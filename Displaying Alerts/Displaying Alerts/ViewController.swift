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
        
        /*
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
        */
        
        controller = UIAlertController(title: "Choose how you would like to share this photo", message: "You Cannot bring back a deleted photo", preferredStyle: .ActionSheet)
        
        let actionEmail: UIAlertAction = UIAlertAction(title: "Via email", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            /* send photo via email */
        })
        
        let actionImessage = UIAlertAction(title: "Via iMessage", style: UIAlertActionStyle.Default) { (action) -> Void in
            /* send photo via iMessage */
        }
        
        let actionDelete = UIAlertAction(title: "Delete Photo", style: .Destructive) { (action) -> Void in
            /* delete the photo */
        }
        
        controller!.addAction(actionEmail);
        controller!.addAction(actionImessage);
        controller!.addAction(actionDelete);
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


//
//  ViewController.swift
//  Sharing with UIActivityViewController
//
//  Created by Guy Azran on 10/29/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var textField: UITextField!;
    var btnShare: UIButton!;
    var activityViewController: UIActivityViewController!; //used for sharing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTextField();
        createButton();
    }
    
    func createTextField(){
        textField = UITextField(frame: CGRect(x: 20, y: 35, width: 280, height: 30));
        textField.borderStyle = .RoundedRect;
        textField.placeholder = "Enter text to share...";
        textField.delegate = self;
        view.addSubview(textField);
    }
    
    func createButton(){
        btnShare = UIButton(type: UIButtonType.System);
        btnShare.frame = CGRect(x: 20, y: 80, width: 280, height: 45);
        btnShare.setTitle("Share", forState: UIControlState.Normal);
        btnShare.addTarget(self, action: "handleShare:", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(btnShare);
    }
    
    func handleShare(sender: UIButton){
        if textField.isFirstResponder(){
            textField.resignFirstResponder(); //lowers the keyboard upon tapping the share button
        }
        
        
        activityViewController = UIActivityViewController(activityItems: [textField.text! as NSString], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil);
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder(); //lowers the keyboard upon tapping the "return" key on the keyboard
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


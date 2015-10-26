//
//  ViewController.swift
//  Basic UI Homework
//
//  Created by Guy Azran on 10/23/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var users: [String: String]?;
    
    var btnLogin:UIButton!;
    
    var lblLoggedIn:UILabel!;
    
    var controller:UIAlertController!;
    var failedController:UIAlertController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = ["guy":"12345", "alissa":"220592"];
        
        btnLogin = UIButton(type: UIButtonType.System);
        btnLogin.frame = CGRect(x: 0, y: 0, width: 100, height: 50);
        btnLogin.center = view.center;
        btnLogin.setTitle("Log In", forState: UIControlState.Normal);
        btnLogin.addTarget(self, action: "showLogInAlert:", forControlEvents: UIControlEvents.TouchUpInside);
        
        
        view.addSubview(btnLogin);
        
        lblLoggedIn = UILabel(frame: CGRect(x: 120, y: 300, width: 100, height: 70));
        lblLoggedIn.text = "Logged Out";
        
        view.addSubview(lblLoggedIn)
        
        controller = UIAlertController(title: "Welcome!", message: "Please fill out your log in information", preferredStyle: UIAlertControllerStyle.Alert);
        
        let actionLogIn = UIAlertAction(title: "Log In", style: UIAlertActionStyle.Default) { [weak self] (action: UIAlertAction) -> Void in
            if let textfields = self!.controller!.textFields{
                var username:String?;
                var password:String?;
                
                if let theUsername = textfields[0].text{
                    username = theUsername;
                }
                
                if let thePassword = textfields[1].text{
                    password = thePassword;
                }
                
                if (username! as NSString).length > 0 && (password! as NSString).length > 0 && self!.users!.keys.contains(username!) && self!.users![username!] == password!{
                    self!.lblLoggedIn.text = "Logged In";
                    self!.btnLogin.setTitle("Log Out", forState: UIControlState.Normal);
                    self!.btnLogin.removeTarget(self, action: "showLogInAlert:", forControlEvents: UIControlEvents.TouchUpInside);
                    self!.btnLogin.addTarget(self, action: "logOut:", forControlEvents: UIControlEvents.TouchUpInside);
                } else{
                    self!.showFailedAlert(nil);
                }
            }
        }
        
        controller.addAction(actionLogIn);
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action: UIAlertAction) -> Void in
            print("alert complete")
        }
        controller.addAction(actionCancel);
        
        controller.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Username";
        }
        controller.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Password";
        }
        
        failedController = UIAlertController(title: "Login Failed", message: "The username or password are incorrect", preferredStyle: UIAlertControllerStyle.Alert);
        
        let actionTryAgain = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default) { [weak self](action) -> Void in
            self!.showLogInAlert(nil);
        }
        failedController.addAction(actionTryAgain);
        
        failedController.addAction(actionCancel);
    }
    
    func showLogInAlert(sender: UIButton?){
        presentViewController(controller!, animated: true, completion: nil);
    }
    
    func showFailedAlert(sender: UIButton?){
        presentViewController(failedController, animated: true, completion: nil);
    }
    
    func logOut(sender: UIButton?){
        btnLogin.setTitle("Log In", forState: UIControlState.Normal);
        btnLogin.removeTarget(self, action: "logOut:", forControlEvents: UIControlEvents.TouchUpInside);
        btnLogin.addTarget(self, action: "showLogInAlert:", forControlEvents: UIControlEvents.TouchUpInside);
        lblLoggedIn.text = "Logged Out"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


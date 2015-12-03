//
//  ViewController.swift
//  WhatsApp Client TCP
//
//  Created by Guy Azran on 11/30/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, TCPClientDelegate {
    
    var btnSend: UIButton!;
    var txtMessage: UITextField!;
    var txtRecipient: UITextField!;
    var lstMessages: UITableView!;
    var messages: [Message] = [Message]();
    var loggedIn = false;
    var loginAlertController : UIAlertController!;
    var username:String!;
    var password:String!;
    var tcpClient: TCPClient!;
    var receivingMessages = false;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        tcpClient = TCPClient();
        tcpClient.delegate = self;
        
        btnSend = UIButton(type: UIButtonType.System);
        
        btnSend.frame = CGRect(x: view.frame.width - 80, y: 40, width: 60, height: 30);
        btnSend.setTitle("Send", forState: UIControlState.Normal);
        btnSend.addTarget(self, action: "btnSend:", forControlEvents: UIControlEvents.TouchUpInside);
        view.addSubview(btnSend);
        
        txtMessage = UITextField(frame: CGRect(x: 10, y: 40, width: view.frame.width - 80 - 10 - 10, height: 30));
        txtMessage.placeholder = "type a message...";
        txtMessage.borderStyle = .RoundedRect;
        txtMessage.delegate = self;
        view.addSubview(txtMessage);
        
        txtRecipient = UITextField(frame: CGRect(x: 10, y: txtMessage.frame.maxY + 10, width: view.frame.width - 20, height: 30));
        txtRecipient.placeholder = "Recipient";
        txtRecipient.borderStyle = .RoundedRect;
        view.addSubview(txtRecipient);
        
        lstMessages = UITableView(frame: CGRect(x: txtMessage.frame.origin.x, y: txtRecipient.frame.maxY + 10, width: txtMessage.frame.width + 10 + btnSend.frame.width, height: view.frame.height - txtMessage.frame.maxY - 10 - 10), style: UITableViewStyle.Plain);
        lstMessages.delegate = self;
        lstMessages.dataSource = self;
        view.addSubview(lstMessages);
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        if !loggedIn{
            loginAlertController = UIAlertController(title: "log in", message: "either signup as a new user or log in as an existing user", preferredStyle: UIAlertControllerStyle.Alert);
            loginAlertController.addTextFieldWithConfigurationHandler({ (textField: UITextField) -> Void in
                textField.placeholder = "Username";
            });
            
            loginAlertController.addTextFieldWithConfigurationHandler({ (textField:UITextField) -> Void in
                textField.placeholder = "Password";
                textField.secureTextEntry = true;
            });
            
            
            let actionSignUP = UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: { [weak self](action: UIAlertAction) -> Void in
                self!.username = self!.loginAlertController.textFields![0].text!;
                self!.password = self!.loginAlertController.textFields![1].text!;
                
                self!.tcpClient.setUser(self!.username, andPassword: self!.password);
                self!.tcpClient.signup();
            });
            
            let actionLogin = UIAlertAction(title: "Log in", style: UIAlertActionStyle.Default, handler: { [weak self](action :UIAlertAction) -> Void in
                self!.username = self!.loginAlertController.textFields![0].text!;
                self!.password = self!.loginAlertController.textFields![1].text!;
                
                self!.tcpClient.setUser(self!.username, andPassword: self!.password);
                self!.tcpClient.login();
            });
            
            loginAlertController.addAction(actionSignUP);
            loginAlertController.addAction(actionLogin);
            
            presentViewController(loginAlertController, animated: true, completion: nil);
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("identifier");
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "identifier");
        }
        cell!.textLabel?.text = messages[indexPath.row].content;
        cell!.detailTextLabel?.text = messages[indexPath.row].sender
        return cell!;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func btnSend(sender: UIButton){
        let recipient = txtRecipient.text;
        if recipient!.isEmpty{
            return;
        }
        
        if let theText = txtMessage.text{
            tcpClient.sendMessage(theText, recipient: recipient!);
        }
        txtMessage.text = "";
    }
    
    func checkForMessages(){
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 3));
        dispatch_after(time, dispatch_get_main_queue(), { [weak self]() -> Void in
            self!.tcpClient.checkForMessages();
        });
    }
    
    func didCheckForNewMessages() {
        if receivingMessages{
            lstMessages.reloadData();
        }
        checkForMessages();
    }
    
    func didLogin(success: Bool) {
        if success{
            checkForMessages();
        }
    }
    
    func didSignUp(success: Bool) {
        if success{
            checkForMessages();
        }
    }
    
    func didReceiveMessage(msg: Message) {
        receivingMessages = true;
        messages.append(msg);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


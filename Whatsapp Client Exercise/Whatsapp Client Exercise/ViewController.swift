//
//  ViewController.swift
//  Whatsapp Client Exercise
//
//  Created by Guy Azran on 11/23/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLSessionDelegate, NSURLSessionDataDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var session: NSURLSession!;
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
    let url = NSURL(string: "http://10.0.0.82:8080/MainServlet");
    var request: NSMutableURLRequest!;
    
    var txtMessage: UITextField!;
    var btnSend: UIButton!;
    var lstMessages: UITableView!;  
    
    var messages = [Message]();
    
    var loggedIn = false;
    
    var loginAlertController: UIAlertController!;
    
    var username: String!;
    var password: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        configuration.timeoutIntervalForRequest = 15.0;
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";
        
        btnSend = UIButton(type: .System);
        btnSend.frame = CGRect(x: view.frame.width - 80, y: 40, width: 60, height: 30);
        btnSend.setTitle("Send", forState: .Normal);
        btnSend.addTarget(self, action: "sendClicked:", forControlEvents: .TouchUpInside);
        view.addSubview(btnSend);
        
        txtMessage = UITextField(frame: CGRect(x: 5, y: 40, width: view.frame.width - 80 - 10 - 10, height: 30));
        txtMessage.placeholder = "Type a message..."
        txtMessage.borderStyle = .RoundedRect;
        view.addSubview(txtMessage);
        
        lstMessages = UITableView(frame: CGRect(x: txtMessage.frame.origin.x, y: txtMessage.frame.maxY + 10, width: btnSend.frame.maxX - txtMessage.frame.origin.x, height: view.frame.height - txtMessage.frame.maxY + 10), style: .Plain);
        lstMessages.delegate = self;
        lstMessages.dataSource = self;
        view.addSubview(lstMessages);
        
        if !loggedIn{
            loginAlertController = UIAlertController(title: "Log in", message: "Either sign up or log in as an existing user", preferredStyle: .Alert);
            loginAlertController.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.placeholder = "username..."
            })
            
            loginAlertController.addTextFieldWithConfigurationHandler({ (textField) -> Void in
                textField.placeholder = "password..."
                textField.secureTextEntry = true;
            })
            
            let actionSignUp = UIAlertAction(title: "Sing up", style: .Default, handler: { [weak self](action) -> Void in
                self!.username = self!.loginAlertController.textFields![0].text!;
                self!.password = self!.loginAlertController.textFields![1].text!;
                
                let messageToServeer:[NSString: AnyObject] = [
                    "action" : "signup",
                    "userName" : self!.username,
                    "password" : self!.password
                ];
                
                do{
                    let task = try self!.session.uploadTaskWithRequest(self!.request, fromData: NSJSONSerialization.dataWithJSONObject(messageToServeer, options: .PrettyPrinted));
                    task.resume();
                } catch{
                    
                }
                });
            
            let actionLogIn = UIAlertAction(title: "Log in", style: .Default, handler: { [weak self](action) -> Void in
                self!.username = self!.loginAlertController.textFields![0].text!;
                self!.password = self!.loginAlertController.textFields![1].text!;
                
                let messageToServeer:[NSString: NSString] = [
                    "action" : "login",
                    "userName" : self!.username,
                    "password" : self!.password
                ];
                
                do{
                    let task = try self!.session.uploadTaskWithRequest(self!.request, fromData: NSJSONSerialization.dataWithJSONObject(messageToServeer, options: .PrettyPrinted));
                    task.resume();
                } catch{
                    
                }
                });
            
            loginAlertController.addAction(actionSignUp);
            loginAlertController.addAction(actionLogIn);
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        presentViewController(loginAlertController, animated: true, completion: nil);
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
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "identifier")
        }
        
        cell!.textLabel?.text = messages[indexPath.row].content;
        cell!.detailTextLabel?.text = messages[indexPath.row].sender;
        
        
        return cell!;
    }
    
    func sendClicked(sender: UIButton){
        if let theText = txtMessage.text{
            sendRequest(theText);
            txtMessage.text = "";
        }
        txtMessage.resignFirstResponder();
    }
    
    func sendRequest(content: String){
        
        var dataToUpload:NSData?;
        
        let dictionary: [NSString : AnyObject] = [
            "action" : "sendmessage",
            "userName" : username,
            "password" : password,
            "recipient" : username,
            "content" : content
        ];
        
        do{
            dataToUpload = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted);
        } catch{
            
        }
        
        let task = session.uploadTaskWithRequest(request, fromData: dataToUpload!);
        task.resume();
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        if !loggedIn{ //response to sign up or log in
            do{
                let responseFromServer = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments);
                if responseFromServer is NSDictionary{
                    let deserializedDictionary = responseFromServer as! NSDictionary;
                    let success = deserializedDictionary["success"] as! Bool;
                    print("success = \(success)");
                    if success{
                        loggedIn = true;
                        checkForMessages();
                    } else {
                        presentViewController(loginAlertController, animated: true, completion: nil);
                    }
                }
            }catch{
                
            }
        } else{ // response for send message or check for messages
            do{
                let responseFromServer = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments);
                if responseFromServer is NSDictionary{
                    let deserializedDictionary = responseFromServer as! NSDictionary;
                    let success = deserializedDictionary["success"] as! Bool;
                    if success{
                        if responseFromServer.count == 2{ //response to check for messages
                            let messages = responseFromServer["messages"] as! NSArray;
                            
                            for var i = 0; i < messages.count; i++ {
                                let msg = messages[i] as! [NSString : NSString];
                                let newMessage = Message(sender: msg["sender"]! as String, content: msg["content"]! as String);
                                self.messages.append(newMessage);
                            }
                            
                            if messages.count > 0{
                                dispatch_async(dispatch_get_main_queue(), { [weak self]() -> Void in
                                    self!.lstMessages.reloadData();
                                    });
                            }
                            
                            print("checked for messages")
                            checkForMessages();
                        }
                    }
                }

                
                
            } catch{
                
            }
        }
    }
    
    func checkForMessages(){
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 3));
        dispatch_after(time, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { [weak self]() -> Void in
            
            let messageToServer:[NSString : AnyObject] = [
                "action" : "checkformessages",
                "userName" : self!.username,
                "password" : self!.password
            ];

            do{
                let task = try self!.session.uploadTaskWithRequest(self!.request, fromData: NSJSONSerialization.dataWithJSONObject(messageToServer, options: .PrettyPrinted));
                task.resume();
            }catch{
                
            }
            
        });
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit{
        session.finishTasksAndInvalidate();
    }
    
}


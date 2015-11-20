//
//  ViewController.swift
//  Uploading Data Using NSURLSession
//
//  Created by Guy Azran on 11/19/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

extension NSURLSessionTask{
    func start(){
        self.resume();
    }
}

class ViewController: UIViewController, NSURLSessionDelegate, NSURLSessionDataDelegate {
    
    var session: NSURLSession!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0;
        
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        
        var dataToUpload = "Giggity Giggity Goo!".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false);
        let url = NSURL(string: "http://10.0.0.92:8080/MainServlet?user=guy&password=12345");
        
        let dictionary: [NSString : AnyObject] = [
            "UserName" : "Guy",
            "Password" : "12345",
            "Friend" : ["FirstName" : "Gil", "LastName" : "Osher"]
        ];
        
        do{
            dataToUpload = try NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted); //PrettyPrinted means the propper syntax of JSON
        } catch{
            
        }
        
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";
        //request.setValue("text", forKey: "Content-type");
        
        
        let task = session.uploadTaskWithRequest(request, fromData: dataToUpload!); //this task is good for POST
        //let task = session.dataTaskWithURL(url!); //this task is good for GET
        task.start();
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        session.finishTasksAndInvalidate();
        print("done \(error)");
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        let responseFromServer = NSString(data: data, encoding: NSUTF8StringEncoding)
        print("did receive data");
        if let theResponseFromServer = responseFromServer{
            print(theResponseFromServer)
            do{
                let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments);
                if jsonObject is NSDictionary{
                    let deserializedDictionary = jsonObject as! NSDictionary;
                    let key1 = deserializedDictionary["key1"];
                    let key2 = deserializedDictionary["key2"];
                    let key3 = deserializedDictionary["key3"];
                    let key3key1 = key3!["key1"];
                    let key3key2 = key3!["key2"];
                    print("key1 = \(key1!)");
                    print("key2 = \(key2!)");
                    print("key3key1 = \(key3key1!)");
                    print("key3key2 = \(key3key2!)");
                    deserializedDictionary.allKeys;
                }
            }catch{
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


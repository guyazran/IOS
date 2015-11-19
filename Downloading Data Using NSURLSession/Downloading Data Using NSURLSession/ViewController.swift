//
//  ViewController.swift
//  Downloading Data Using NSURLSession
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

class ViewController: UIViewController, NSURLSessionDelegate {

    var session: NSURLSession!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration();
        configuration.timeoutIntervalForRequest = 15.0; //how much time the session waits until it throws an exception (timeout)
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil);
        
        let url = NSURL(string: "http://www.ebay.com/sch/i.html?_from=R40&_trksid=p2050601.m570.l1313.TR0.TRC0.H0.Xiphone.TRS0&_nkw=iphone&_sacat=0");
        
        let task = session.dataTaskWithURL(url!) { [weak self](data, response, error) -> Void in
            print("done. is main thread? \(NSThread.currentThread().isMainThread)");
            if error == nil{
                if let theData = data{
                    if theData.length > 0{
                        let responseAsString = NSString(data: theData, encoding: NSUTF8StringEncoding);
                        print(responseAsString);
                    }
                }
            }
            self!.session.finishTasksAndInvalidate();
        };
        task.start();
        print("finished ViewDidLoad");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


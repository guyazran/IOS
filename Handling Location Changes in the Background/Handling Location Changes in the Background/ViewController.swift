//
//  ViewController.swift
//  Handling Location Changes in the Background
//
//  Created by Guy Azran on 11/12/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var latLabel: UILabel!;
    var lat: UILabel!;
    
    var longLabel: UILabel!;
    var long: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latLabel = UILabel(frame: CGRect(x: 10, y: 20, width: view.frame.width, height: 30));
        latLabel.text = "Latitude:";
        lat = UILabel(frame: CGRect(x: 10, y: 60, width: view.frame.width, height: 30));
        
        longLabel = UILabel(frame: CGRect(x: 10, y: 100, width: view.frame.width, height: 30));
        longLabel.text = "Longitude:";
        long = UILabel(frame: CGRect(x: 10, y: 140, width: view.frame.width, height: 30));
        
        view.addSubview(latLabel);
        view.addSubview(lat);
        view.addSubview(longLabel);
        view.addSubview(long);
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNewLocation:", name: "locationUpdated", object: nil);
    }
    
    func handleNewLocation(notification: NSNotification){
        print("lat", notification.userInfo!["lat"], "long", notification.userInfo!["long"]);
        
        lat.text = "\(notification.userInfo!["lat"])";
        long.text = "\(notification.userInfo!["long"])";
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }


}


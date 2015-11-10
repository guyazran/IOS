//
//  ViewController.swift
//  Background Fetch Capabilities
//
//  Created by Guy Azran on 11/9/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let cellReuseIdentifier = "cellReuseIdentifier";
    var tableView: UITableView!;
    
    var mustReloadView = false;
    
    var getNewsItemsTimer: NSTimer!;
    
    var newsItems:[NewsItem]{
        get{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
            return appDelegate.newsItems;
        } set{
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
            appDelegate.newsItems = newValue;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleNewsItemsChanged:", name: AppDelegate.newsItemsChangedNotification(), object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleAppIsBroughtToForeground:", name: UIApplicationWillEnterForegroundNotification, object: nil);
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleAppIsBroughtToBackground:", name: UIApplicationDidEnterBackgroundNotification, object: nil);
        
        tableView = UITableView(frame: view.bounds, style: .Plain);
        tableView.frame.origin.y += 20;
        
        tableView.dataSource = self
        
        let autoResizing = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue);
        tableView.autoresizingMask = autoResizing;
        
        view.addSubview(tableView);
        
        getNewsItemsTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "getNewsUpdates:", userInfo: nil, repeats: true);

    }
    
    func handleNewsItemsChanged(notification: NSNotification){
        if isBeingPresented(){
            tableView.reloadData();
        } else{
            mustReloadView = true;
        }
    }
    
    func handleAppIsBroughtToForeground(notification: NSNotification){
        if mustReloadView{
            tableView.reloadData();
        }
        getNewsItemsTimer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: "getNewsUpdates:", userInfo: nil, repeats: true);
    }
    
    func handleAppIsBroughtToBackground(notification: NSNotification){
        getNewsItemsTimer.invalidate();
        getNewsItemsTimer = nil;
    }
    
    func getNewsUpdates(sender: NSTimer){
        newsItems.insert(NewsItem(date: NSDate(), text: "News Item \(newsItems.count)"), atIndex: 0);
        tableView.reloadData();
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier);
        if cell == nil{
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellReuseIdentifier);
        }
        
        cell!.textLabel!.text = newsItems[indexPath.row].text;
        cell!.detailTextLabel!.text = newsItems[indexPath.row].date.description;
        
        return cell!;
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


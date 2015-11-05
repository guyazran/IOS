//
//  ViewController.swift
//  TableView with Refresh Button
//
//  Created by Guy Azran on 11/5/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView?;
    var allTimes = [NSDate]();
    var refreshControl: UIRefreshControl?;
    
    let identifier = "identifier";

    override func viewDidLoad() {
        super.viewDidLoad()
        
        allTimes.append(NSDate());
        
        tableView = UITableView(frame: view.bounds, style: UITableViewStyle.Plain);
        if let theTableView = tableView{
            theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier);
            theTableView.dataSource = self;
            
            //create the refresh control
            refreshControl = UIRefreshControl();
            refreshControl!.addTarget(self, action: "handleRefresh:", forControlEvents: .ValueChanged);
            theTableView.addSubview(refreshControl!);
            view.addSubview(theTableView);
        }
        
    }
    
    func handleRefresh(sender: UIRefreshControl){
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_MSEC)*2);
        dispatch_after(popTime, dispatch_get_main_queue()) { [weak self]() -> Void in
            self!.allTimes.append(NSDate());
            self!.refreshControl!.endRefreshing();
            let indexPathOFNewRow = NSIndexPath(forRow: self!.allTimes.count - 1, inSection: 0);
            self!.tableView!.insertRowsAtIndexPaths([indexPathOFNewRow], withRowAnimation: .Automatic);
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTimes.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath);
        cell.textLabel?.text = "\(allTimes[indexPath.row])";
        
        return cell;
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


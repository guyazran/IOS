//
//  ViewController.swift
//  Learning TableView
//
//  Created by Guy Azran on 11/5/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView?;
    var numberOfRows = [3, 5, 8];
    
    let identifier = "identifier";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .Grouped);
        
        if let theTableView = tableView{
            theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier);
            theTableView.dataSource = self;
            theTableView.delegate = self;
            
            let autoResizing = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue);
            theTableView.autoresizingMask = autoResizing;
            
            view.addSubview(theTableView)
        }
        
    }
    
    func newLabelWithTitle(title: String) -> UILabel{
        let label = UILabel();
        label.text = title;
        label.backgroundColor = UIColor.clearColor();
        label.sizeToFit();
        return label;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30;
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return newLabelWithTitle("Section \(section) Header");
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return newLabelWithTitle("Section \(section) Footer");
    }
    
    //optional. sections are not mandatory in a tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3;
    }
    
    //required
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows[section];
    }
    
    //required
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath);
        cell.textLabel?.text = "Section \(indexPath.section), Cell \(indexPath.row)";
        
        return cell;
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete;
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated);
        tableView!.setEditing(editing, animated: animated);
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        numberOfRows[indexPath.section]--;
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
















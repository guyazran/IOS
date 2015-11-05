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
    //var numberOfRows = [3, 5, 8];

    var messages = [Message(sender: "Guy", content: "hi..."), Message(sender: "Ariel", content: "bye"), Message(sender: "gal", content: "yo"), Message(sender: "gil", content: "fo sho")];
    
    let identifier = "identifier";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView = UITableView(frame: view.bounds, style: .Grouped);
        tableView = UITableView(frame: view.bounds, style: .Plain);
        
        if let theTableView = tableView{
            //theTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier); //no need to register when i initialize the cells manually
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
    
    /*
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
    */
    
    //required
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return numberOfRows[section];
        return messages.count;
    }
    
    //required
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        //this is a way to recycle any view in a tableview
//        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath);
//        
//        //cell.textLabel?.text = "Section \(indexPath.section), Cell \(indexPath.row)";
//        cell.textLabel?.text = messages[indexPath.row].content;
//        
//        var lblSender:UILabel?;
//        for childView in cell.contentView.subviews{
//            if childView.tag == 15{
//                lblSender = childView as? UILabel;
//                break;
//            }
//        }
//        if lblSender == nil{
//            lblSender = UILabel();
//        }
//        
//        lblSender!.text = messages[indexPath.row].sender;
//        lblSender!.font = UIFont.systemFontOfSize(10);
//        lblSender!.sizeToFit();
//        lblSender!.frame.origin.x = cell.contentView.frame.width - lblSender!.frame.width - 10;
//        lblSender!.frame.origin.y = cell.contentView.frame.height - lblSender!.frame.height - 5;
//        lblSender!.tag = 15;
//        
//        cell.contentView.addSubview(lblSender!);
//        
//        return cell;
        
        //if we want to initialize the cell we do not need to register the tableview (different identifier)
        var cell = tableView.dequeueReusableCellWithIdentifier("CELL"); //this method returns an optional
        
        if cell == nil {
            //in the first initializations of the cells we initialize them manually
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "CELL"); //this allows to use different cell styles
        }

        
        cell!.textLabel?.text = messages[indexPath.row].content
        cell!.detailTextLabel?.text = messages[indexPath.row].sender; //now we can use detailedTextLabel that is shown in the subtitle style
        
        return cell!
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete;
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated);
        tableView!.setEditing(editing, animated: animated);
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //numberOfRows[indexPath.section]--;
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
















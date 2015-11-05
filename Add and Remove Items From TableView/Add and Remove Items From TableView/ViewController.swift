//
//  ViewController.swift
//  Add and Remove Items From TableView
//
//  Created by Guy Azran on 11/5/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!;
    var btnAddWorker: UIButton!;
    var nameTextField: UITextField!;
    var idTextField: UITextField!;
    
    var items = [Worker(name: "guy", id: 1), Worker(name: "gal", id: 2), Worker(name: "gil", id: 3)]
    
    let identifier = "identifier";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y + 20, width: view.bounds.width, height: view.bounds.height - 60), style: .Plain)
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier);
        tableView.dataSource = self;
        tableView.delegate = self;
        
        let autoResizing = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue);
        
        tableView.autoresizingMask = autoResizing;
        
        view.addSubview(tableView);
        
        btnAddWorker = UIButton(type: .ContactAdd);
        btnAddWorker.frame = CGRect(x: view.center.x - 15, y: tableView.frame.maxY, width: 30, height: 30);
        btnAddWorker.addTarget(self, action: "btnAddWorker:", forControlEvents: .TouchUpInside);
        view.addSubview(btnAddWorker);
        
    }
    
    func btnAddWorker(sender: UIButton){
        let alert = UIAlertController(title: "Add a New Worker", message: "Please ender a name and an ID number", preferredStyle: .Alert);
        alert.addTextFieldWithConfigurationHandler { [weak self](textField) -> Void in
            self!.nameTextField = textField;
            textField.placeholder = "Name";
        }
        alert.addTextFieldWithConfigurationHandler { [weak self](textField) -> Void in
            self!.idTextField = textField;
            textField.placeholder = "ID";
        }
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { [weak self](action) -> Void in
            
            if let theName = self!.nameTextField.text{
                if let theId = self!.idTextField.text{
                    if let numId = Int(theId){
                        self!.items.append(Worker(name: theName, id: numId));
                        self!.tableView.reloadData();
                        return;
                    }
                }
            }
            
            let badInputAlert = UIAlertController(title: "Invalid Info", message: "The name and ID you have provided are invalid. Please enter your the worker's name and an ID that is comprised of digits only", preferredStyle: .Alert);
            badInputAlert.addAction(UIAlertAction(title: "Try Again", style: .Default, handler: { (action) -> Void in
                self!.presentViewController(alert, animated: true, completion: nil);
            }));
            badInputAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil));
            
            self!.presentViewController(badInputAlert, animated: true, completion: nil);
            
            
            
        }));
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil));
        presentViewController(alert, animated: true, completion: nil);
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath);
        cell.textLabel?.text = "Name: \(items[indexPath.row].name), ID: \(items[indexPath.row].id)";
        return cell;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


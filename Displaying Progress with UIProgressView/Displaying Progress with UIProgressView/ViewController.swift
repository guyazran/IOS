//
//  ViewController.swift
//  Displaying Progress with UIProgressView
//
//  Created by Guy Azran on 11/2/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var progressView: UIProgressView!;
    
    var btnAdd: UIButton!;
    var btnReduce: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = UIProgressView(progressViewStyle: .Bar);
        progressView.center = view.center;
        progressView.progress = 0.5;
        progressView.trackTintColor = UIColor.lightGrayColor();
        progressView.tintColor = UIColor.blueColor();
        view.addSubview(progressView);
        
        btnAdd = UIButton(type: .System);
        btnAdd.frame = CGRect(x: 0, y: 0, width: 35, height: 20);
        btnAdd.center = view.center;
        btnAdd.frame.origin.x = progressView.frame.maxX;
        btnAdd.setTitle("+", forState: .Normal);
        view.addSubview(btnAdd);
        
        btnReduce = UIButton(type: .System);
        btnReduce.frame = CGRect(x: 0, y: 0, width: 35, height: 20);
        btnReduce.center = view.center;
        btnReduce.frame.origin.x = progressView.frame.origin.x;
        btnReduce.frame.origin.x -= btnReduce.frame.width;
        btnReduce.setTitle("-", forState: .Normal);
        view.addSubview(btnReduce);
        
        btnAdd.addTarget(self, action: "btnAddProgress:", forControlEvents: UIControlEvents.TouchUpInside);
        btnReduce.addTarget(self, action: "btnReduceProgress:", forControlEvents: .TouchUpInside);
    }
    
    func btnAddProgress(sender: UIButton){
        if progressView.progress != 1{
            progressView.progress += 0.1;
        }
    }
    
    func btnReduceProgress(sender: UIButton){
        if progressView.progress != 0{
            progressView.progress -= 0.1;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


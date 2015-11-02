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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = UIProgressView(progressViewStyle: .Bar);
        progressView.center = view.center;
        progressView.progress = 0.5;
        progressView.trackTintColor = UIColor.lightGrayColor();
        progressView.tintColor = UIColor.blueColor();
        view.addSubview(progressView);
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


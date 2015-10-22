//
//  ViewController.swift
//  Displaying Static Text With UILabel
//
//  Created by Guy Azran on 10/22/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 70));
        label.numberOfLines = 3;
        label.text = "hello world, how are you today? are you having fun?";
        //label.lineBreakMode = .ByWordWrapping; //keeps the words whole
        //label.lineBreakMode = .ByCharWrapping; //cuts the words in the middle
        //label.lineBreakMode = .ByClipping; //cuts the charaters in the middle
        //label.lineBreakMode = .ByTruncatingHead; //removes begining and adds "..." instead
        //label.lineBreakMode = .ByTruncatingTail; //removes begining and adds "..." instead (this is the default mode)
        label.adjustsFontSizeToFitWidth = true; //overrides boldSystemFontOfSize
        label.font = UIFont.boldSystemFontOfSize(14);
        view.addSubview(label);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


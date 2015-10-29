//
//  ViewController.swift
//  Learning UISegmentedControl
//
//  Created by Guy Azran on 10/29/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var segmentedControl: UISegmentedControl!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let segments = ["iPhone", "iPad", "iWatch", "iMac"];
        
        let segments = ["iPhone", UIImage(named: "bird")!, "iPad", "iWatch"]; //image color is determined by the tint!!!!!
        
        segmentedControl = UISegmentedControl(items: segments);
        segmentedControl.center = view.center;
        
        view.addSubview(segmentedControl);
        
        segmentedControl.addTarget(self, action: "segmentedControlValueChanged:", forControlEvents: UIControlEvents.ValueChanged);
        
        //segmentedControl.momentary = true; //does not keep the selection highlighted after it is released by the user
        
        segmentedControl.selectedSegmentIndex = 0; //makes the segment at a certain index selected
    }
    
    func segmentedControlValueChanged(control: UISegmentedControl){
        let selectedSegmentIndex = control.selectedSegmentIndex;
        
        let selectedSegmentText = control.titleForSegmentAtIndex(selectedSegmentIndex);
        
        var text = "no text";
        if let theSelectedSegmentText = selectedSegmentText{
            text = theSelectedSegmentText;
        }
        
        print("Segment \(selectedSegmentIndex) with text \(text)");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


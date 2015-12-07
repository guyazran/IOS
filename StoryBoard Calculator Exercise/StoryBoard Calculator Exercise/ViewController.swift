//
//  ViewController.swift
//  StoryBoard Calculator Exercise
//
//  Created by Guy Azran on 12/7/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtTopNum: UITextField!
    @IBOutlet weak var txtBottomNum: UITextField!
    @IBOutlet weak var txtSum: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func CalculateSum(sender: UIButton) {
        var topNum:Double? = nil;
        if let theText = txtTopNum.text{
            topNum = Double(theText);
        }
        
        var bottomNum:Double? = nil;
        if let theText = txtBottomNum.text{
            bottomNum = Double(theText);
        }
        
        if topNum != nil && bottomNum != nil{
            let result = topNum! + bottomNum!;
            txtSum.text = result.description;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


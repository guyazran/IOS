//
//  ViewController.swift
//  Using the StoryBoard
//
//  Created by Guy Azran on 12/7/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblTitle: UILabel!;
    @IBOutlet weak var txtInput: UITextField!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtInput.delegate = self;
    }
    
    @IBAction func handleClick(sender: UIButton) {
        lblTitle.text = txtInput.text;
        txtInput.resignFirstResponder();
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        handleClick(UIButton())
        txtInput.resignFirstResponder();
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


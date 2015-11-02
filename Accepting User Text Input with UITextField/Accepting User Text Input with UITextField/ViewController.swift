//
//  ViewController.swift
//  Accepting User Text Input with UITextField
//
//  Created by Guy Azran on 11/2/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var textField: UITextField!;
    
    var label: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 35));
        textField.center = view.center;
        textField.borderStyle = .RoundedRect;
        //textField.contentVerticalAlignment = .Center;
        textField.textAlignment = .Center;
        textField.text = "some initial text";
        textField.delegate = self;
        view.addSubview(textField);
        
        label = UILabel(frame: CGRect(x: 40, y: 60, width: 220, height: 35));
        view.addSubview(label);
        calculateAndDisplayTextFieldLengthWithText(textField.text!);
    }
    
    func calculateAndDisplayTextFieldLengthWithText(text: String){
        var characterOrCharacters = "Character";
        let l = (text as NSString).length;
        if l != 1{
            characterOrCharacters += "s";
        }
        label.text = "\(l) \(characterOrCharacters)";
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        //the textfield has not been changed yet when this function is invoked
        let text = textField.text! as NSString; //the text here is the text before the textfield has been changed
        let wholeText = text.stringByReplacingCharactersInRange(range, withString: string) //returns the new string is created by performing the action from the keyboard
        calculateAndDisplayTextFieldLengthWithText(wholeText);
        
        return true;
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


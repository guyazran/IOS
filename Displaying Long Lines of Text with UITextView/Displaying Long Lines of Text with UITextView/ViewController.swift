//
//  ViewController.swift
//  Displaying Long Lines of Text with UITextView
//
//  Created by Guy Azran on 11/2/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textView: UITextView?;
    
    let defaultContentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0);
    
    func handleKeyboardDidShow(notification: NSNotification){
        //get the frame of the keyboard
        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue;
        
        //place it in a CGRect
        var keyboardRect = CGRectZero;
        keyboardRectAsObject.getValue(&keyboardRect);
        
        //Give a bottom margin to our textView to make it reach the top of the keyboard
        textView!.contentInset = defaultContentInset;
        textView!.contentInset.bottom = keyboardRect.height;
    }
    
    func handleKeyboardWillHide(notification: NSNotification){
        textView!.contentInset = defaultContentInset;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView(frame: view.bounds);
        
        if let theTextView = textView{
            theTextView.text = "Some text goes here...";
            theTextView.contentInset = defaultContentInset;
            theTextView.font = UIFont.systemFontOfSize(16);
            view.addSubview(theTextView);
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleKeyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }

    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self); //removes all observers for that pointer
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


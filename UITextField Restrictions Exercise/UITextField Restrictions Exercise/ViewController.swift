//
//  ViewController.swift
//  UITextField Restrictions Exercise
//
//  Created by Guy Azran on 11/2/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var text:UITextField!;
    
    var hasDecimalPoint:Bool = false;
    
    var isFirstCharZero:Bool = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        text = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 35));
        text.center = view.center;
        text.borderStyle = .RoundedRect;
        text.contentVerticalAlignment = .Center;
        text.textAlignment = .Center;
        text.delegate = self;
        view.addSubview(text);
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText = text.text! as NSString;
        let newText = oldText.stringByReplacingCharactersInRange(range, withString: string) as NSString;
        hasDecimalPoint = false;
        
        for i in 0..<newText.length{
            let charByte = newText.characterAtIndex(i);
            
            if i == 0 && charByte == 48 && newText.length>1{
                if newText.characterAtIndex(1) == 46{
                    
                }else{
                    return false;
                }
            }
            
            if charByte == 46{
                if hasDecimalPoint || i == 0{
                    return false
                }
                hasDecimalPoint = true;
                continue;
            }
            
            if !(charByte >= 48 && charByte <= 57){
                return false;
            }
        }
        
        return true;
        
        /*
        //this only wors if the added characters are added to the end
        if oldText.length < newText.length{ //character added
            let addedCharByte = newText.characterAtIndex(newText.length - 1);
            if addedCharByte == 46{
                if hasDecimalPoint || oldText.length == 0{
                    return false;
                } else{
                    hasDecimalPoint = true;
                    return true;
                }
            }
            if addedCharByte >= 49 && addedCharByte <= 57{
                if isFirstCharZero && !hasDecimalPoint{
                    return false
                }
                return true;
            }
            if addedCharByte == 48{
                if oldText.length == 0{
                    isFirstCharZero = true;
                    return true;
                }
                if hasDecimalPoint{
                    return true;
                }
                if isFirstCharZero{
                    return false
                }
                return true
            }
        } else { //character removed
            let removedCharByte = oldText.characterAtIndex(oldText.length - 1);
            if removedCharByte == 46{
                hasDecimalPoint = false;
            }
            if isFirstCharZero && newText.length == 0{
                isFirstCharZero = false;
            }
            return true;
        }
        
        return false;
        */
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        text.resignFirstResponder();
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  What Is My Date of Birth
//
//  Created by Guy Azran on 10/26/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var picker: UIPickerView!;
    
    var btnGetDay:UIButton!;
    
    var datePickerViewDelegate:DatePickerViewDelegate!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker = UIPickerView();
        picker.center = view.center;
        
        datePickerViewDelegate = DatePickerViewDelegate();
        
        picker.dataSource = datePickerViewDelegate;
        picker.delegate = datePickerViewDelegate;
        
        datePickerViewDelegate.setToToday(picker);
        
        view.addSubview(picker);
        
        let btnX = picker.frame.origin.x
        let btnY = picker.frame.maxY;
        btnGetDay = UIButton(type: UIButtonType.System);
        btnGetDay.frame = CGRect(x: btnX, y: btnY, width: 150, height: 40);
        btnGetDay.setTitle("Get Day in Year", forState: UIControlState.Normal);
        btnGetDay.addTarget(self, action: "btnGetDayInYear:", forControlEvents: UIControlEvents.TouchUpInside);
        
        view.addSubview(btnGetDay);
    }
    
    
    
    func btnGetDayInYear(sender: UIButton){
        let message = "Your birthday this year is on a \(datePickerViewDelegate.getDayInYear())";
        alert(message, title: "What day is your birthday?")
    }
    
    func alert(message: String, title: String, whatToDo: ((UIAlertAction) -> Void)? = nil){
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert);
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: whatToDo);
        
        controller.addAction(okAction);
        presentViewController(controller, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


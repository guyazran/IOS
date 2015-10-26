//
//  ViewController.swift
//  Picking The Date And Time with UIDatePicker
//
//  Created by Guy Azran on 10/26/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var datePicker: UIDatePicker!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker();
        datePicker.center = view.center;
        view.addSubview(datePicker);
        
        datePicker.addTarget(self, action: "datePickerDateChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        let oneYearTime:NSTimeInterval = 365 * 24 * 60 * 60;
        let today = NSDate();
        
        let oneYearFromToday = today.dateByAddingTimeInterval(oneYearTime);
        let twoYearsFromToday = today.dateByAddingTimeInterval(2 * oneYearTime)
        
        datePicker.minimumDate = oneYearFromToday;
        datePicker.maximumDate = twoYearsFromToday;
    }
    
    func datePickerDateChanged(sender: UIDatePicker){
        let chosenDate = datePicker.date;
        let hour = NSCalendar.currentCalendar().component(NSCalendarUnit.Hour, fromDate: chosenDate);
        print(chosenDate.description);
        print("hour = ", hour);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


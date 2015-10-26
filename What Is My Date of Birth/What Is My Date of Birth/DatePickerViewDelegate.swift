//
//  DatePickerViewDelegate.swift
//  What Is My Date of Birth
//
//  Created by Guy Azran on 10/26/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class DatePickerViewDelegate: NSObject, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    var daysOfWeek = ["Sunday", "Monday", "Tuesday", "WednesDay", "Thursday", "Friday", "Saturday"];
    
    var selectedMonth = 0;
    var selectedDay = 0;
    
    func setToToday(picker: UIPickerView){
        let today = NSDate();
        let todayMonth = NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: today) - 1;
        let todayDay = NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: today) - 1;
        selectedMonth = todayMonth;
        selectedDay = todayDay;
        
        picker.selectRow(selectedMonth, inComponent: 0, animated: false);
        picker.selectRow(selectedDay, inComponent: 1, animated: false);
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return months.count;
        }
        if component == 1{
            if selectedMonth > -1 && selectedMonth < daysInMonth.count{
                return daysInMonth[selectedMonth];
            } else{
                return 31;
            }
        }
        return 0;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return months[row];
        }
        if component == 1{
            return "\(row + 1)";
        }
        
        return nil
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            let shouldReload = daysInMonth[row] != daysInMonth[selectedMonth];
            selectedMonth = row;
            if shouldReload{
                pickerView.reloadComponent(1);
            }
        }
        if component == 1{
            selectedDay = row;
        }
    }
    
    func getDayInYear() -> String{
        var daysPassedFromYearStart = 0;
        
        for i in 0..<selectedMonth{
            daysPassedFromYearStart += daysInMonth[i];
        }
        
        daysPassedFromYearStart += selectedDay;
        
        return daysOfWeek[(daysPassedFromYearStart + 4) % 7];
    }
}
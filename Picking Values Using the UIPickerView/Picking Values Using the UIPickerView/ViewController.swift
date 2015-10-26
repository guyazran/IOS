//
//  ViewController.swift
//  Picking Values Using the UIPickerView
//
//  Created by Guy Azran on 10/26/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var picker: UIPickerView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker = UIPickerView();
        picker.center = view.center;
        picker.dataSource = self;
        picker.delegate = self;
        view.addSubview(picker);
    }
    
    //tells the PickerView how many components (columns) it should have
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        if pickerView == picker{
            return 1;
        }
        return 0;
    }
    
    //tells the Pickerview how many rows (options) a given component should have
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == picker{
            return 10;
        }
        return 0;
    }
    
    //tells the PickerView what should appear in a given row, in a fgiven component. this is the content of the pickerView
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)";
    }
    
    //notifies that the user has selected a value on the PickerView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


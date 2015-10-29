//
//  ViewController.swift
//  Range Pickers with UISlider
//
//  Created by Guy Azran on 10/29/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var slider: UISlider!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 200));
        slider.center = view.center;
        slider.minimumValue = 0;
        slider.maximumValue = 100;
        slider.value = 50;
        view.addSubview(slider);
        
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: UIControlEvents.ValueChanged);
        //slider.continuous = false; //ValueChanged evvents do not trigger the event until the slider is released by the user (default: true)
        
        slider.setThumbImage(UIImage(named: "smiley"), forState: UIControlState.Normal);
        slider.setThumbImage(UIImage(named: "sponge"), forState: UIControlState.Highlighted);
        slider.tintColor = UIColor.greenColor();
    }
    
    func sliderValueChanged(slider: UISlider){
        print("Slider's value is \(slider.value)");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


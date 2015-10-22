//
//  ViewController.swift
//  Adding Buttons Using UIButton
//
//  Created by Guy Azran on 10/22/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton(type: UIButtonType.Custom);
        button.frame = CGRect(x: 110, y: 70, width: 100, height: 50);
        button.setTitle("Press Me", forState: UIControlState.Normal);
        button.setTitle("I'm Pressed", forState: UIControlState.Highlighted);
        
        let normalImagge = UIImage(named: "red_button");
        let highlightedImage = UIImage(named: "grey_button");
        
        button.setBackgroundImage(normalImagge, forState: .Normal);
        button.setBackgroundImage(highlightedImage, forState: .Highlighted);
        
        button.addTarget(self, action: "buttonIsPressed:", forControlEvents: UIControlEvents.TouchDown);
        button.addTarget(self, action: "buttonIsTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(button);
    }
    
    func buttonIsPressed(sender: UIButton){
        print("button is pressed");
    }
    
    func buttonIsTapped(sender: UIButton){
        print("button is tapped");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


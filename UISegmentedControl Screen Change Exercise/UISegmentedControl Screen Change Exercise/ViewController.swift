//
//  ViewController.swift
//  UISegmentedControl Screen Change Exercise
//
//  Created by Guy Azran on 10/29/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tabs: UISegmentedControl!;
    var container: UIView!;
    
    var screens: [UIView]!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = ["iPhone", "iPad", "iWatch", "iMac"];
        tabs = UISegmentedControl(items: items);
        tabs.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 40)
        tabs.center.x = view.center.x;
        tabs.selectedSegmentIndex = 0;
        
        tabs.addTarget(self, action: "tabSelected:", forControlEvents: UIControlEvents.ValueChanged);
        
        view.addSubview(tabs);
        
        container = UIView(frame: CGRect(x: view.frame.origin.x, y: tabs.frame.maxY, width: view.frame.width, height: view.frame.height - tabs.frame.height));
        view.addSubview(container);
        container.backgroundColor = UIColor.redColor();
        
        let screenSize = CGRect(x: 20, y: 20, width: view.frame.width - 40, height: view.frame.height - tabs.frame.height - 60);
        screens = [UIView(frame: screenSize), UIView(frame: screenSize), UIView(frame: screenSize), UIView(frame: screenSize)];
        screens[0].backgroundColor = UIColor.purpleColor();
        screens[1].backgroundColor = UIColor.greenColor()
        screens[2].backgroundColor = UIColor.blueColor();
        screens[3].backgroundColor = UIColor.orangeColor();
        
        for screen in screens{
            container.addSubview(screen);
        }
        
        screens[0].hidden = false;
        screens[1].hidden = true;
        screens[2].hidden = true;
        screens[3].hidden = true;
        
        let imageViews = [UIImageView(image: UIImage(named: "iPhone")), UIImageView(image: UIImage(named: "iPad")), UIImageView(image: UIImage(named: "iWatch")), UIImageView(image: UIImage(named: "iMac"))];
        
        for i in 0..<imageViews.count{
            imageViews[i].frame = CGRect(x: 0, y: 0, width: screens[i].frame.width, height: screens[i].frame.height);
            imageViews[i].contentMode = .ScaleAspectFit;
            screens[i].addSubview(imageViews[i]);
        }
    }
    
    func tabSelected(tabs: UISegmentedControl){
        for i in 0..<screens.count{

            //not optimized
//            if i == tabs.selectedSegmentIndex{
//                screens[i].hidden = false;
//                continue;
//            }
//            screens[i].hidden = true;
            
            //optimized
            screens[i].hidden = i != tabs.selectedSegmentIndex;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  Displaying Images with UIImageView
//
//  Created by Guy Azran on 10/22/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let image = UIImage(named: "dog");
    var imageView: UIImageView!;
    
    required init?(coder aDecoder: NSCoder) { //required init requires the use of super. a "?" in "init?" means that the initializer can fail without crashing.
        //imageView = UIImageView(image: image); //this can also be done in the viewDidLoad function
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() { //this function is called (not by me) when the main view is ready;
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("the view was loaded");
        /*
        if imageView == nil{
            imageView = UIImageView(image: image);
        }
        //this can also be done in the ViewController initializer
        */
        imageView = UIImageView(frame: view.bounds); //constricts the imageview to the boundries of the screen
        imageView.image = image;
        imageView.contentMode = UIViewContentMode.ScaleAspectFit; //scales the image so as to fit in the imageview without losing proportion
        imageView.center = view.center;
        view.addSubview(imageView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  Files and Folders
//
//  Created by Guy Azran on 12/7/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        //get path to the app's directory
        let filemanager = NSFileManager();
        let urls = filemanager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask);
        if urls.count > 0{
            let documentsFolder = urls[0];
            print("doncumentsFolder = \(documentsFolder)");
        }
        */
        
        //get path to temporary directory. this directory is cleared at a high frequency
        let tempDirectory = NSTemporaryDirectory();
        print("tempDirectory = \(tempDirectory)");
        
        let someText = NSString(string: "some text we want to save");
        let destinationPath = NSTemporaryDirectory() + "MyFile.txt";
        
        do{
            
            //write string to file
            try someText.writeToFile(destinationPath, atomically: true, encoding: NSUTF8StringEncoding);
            let readString = try NSString(contentsOfFile: destinationPath, encoding: NSUTF8StringEncoding);
            print(readString);
            
        } catch{
            
        }
        
        //write array to file (also works with dictionary)
        let arrayOfNames: NSArray = ["Gil", "Ariel", "Guy", true];
        arrayOfNames.writeToFile(destinationPath, atomically: true);
        
        let arrayOfNamesFromFile = NSArray(contentsOfFile: destinationPath);
        for i in 0..<arrayOfNamesFromFile!.count{
            if i < 3 {
                let name = arrayOfNamesFromFile![i] as! String;
                print(name);
            } else if i == 3 {
                let boolean = arrayOfNamesFromFile![i] as! Bool;
                print("boolean is \(boolean)");
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


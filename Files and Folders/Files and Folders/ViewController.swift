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
        
        /*
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
        */
        
        /*
        //directory management
        do{
            //how to create a folder on disk
            let tempPath = NSTemporaryDirectory() as NSString;
            let imagesPath = tempPath.stringByAppendingPathComponent("images");
            try NSFileManager().createDirectoryAtPath(imagesPath, withIntermediateDirectories: true, attributes: nil);
            //this function does not overwrite an existing folder
         
            //how to get a list of folders and files that exist in a certain folder:
            //get a string array of all files in the directory
            let directoryContent = try NSFileManager().contentsOfDirectoryAtPath(NSTemporaryDirectory());
            for dir in directoryContent{
                print(dir);
            }
            
            //get a NSURL array of all files with their properties
            let propertiesToGet = [
                NSURLIsDirectoryKey,
                NSURLIsReadableKey,
                NSURLIsWritableKey,
                NSURLCreationDateKey,
                NSURLContentAccessDateKey,
                NSURLContentModificationDateKey,
                NSURLIsHiddenKey
            ];
            
            let directoryContentWithInfo = try NSFileManager().contentsOfDirectoryAtURL(NSURL(string: NSTemporaryDirectory())!, includingPropertiesForKeys: propertiesToGet, options: .SkipsHiddenFiles);
            for url in directoryContentWithInfo{
                print(url.absoluteString);
                
                //get boolean from properties
                var value: AnyObject?;
                try url.getResourceValue(&value, forKey: NSURLIsDirectoryKey);
                let number = value as! NSNumber;
                let isDirectory = number.boolValue;
                print("is directory = \(isDirectory)");
                
                //get date from properties
                try url.getResourceValue(&value, forKey: NSURLCreationDateKey);
                let creationDate = value as! NSDate;
                print("creation date = \(creationDate.description)");
            }
            
        } catch {
            
        }
        */
        
        /*
        //how to delete a file or folder
        do{
            let destinationPath = ((NSTemporaryDirectory() as NSString).stringByAppendingPathComponent("images") as NSString).stringByAppendingPathComponent("MyFile.txt");
            try NSFileManager().removeItemAtPath(destinationPath);
            print("MyFile.txt was deleted");
        } catch{
            
        }
        */
        
        //saving objects to files
        let destinationPath = NSTemporaryDirectory() + "person.dat";
        let p1 = Person(firstName: "Gil", lastName: "Osher Hamelech");
        NSKeyedArchiver.archiveRootObject(p1, toFile: destinationPath);
        
        var p2 = NSKeyedUnarchiver.unarchiveObjectWithFile(destinationPath) as! Person;
        print("\(p2.firstName) \(p2.lastName)")
        
        let dogPath = NSTemporaryDirectory() + "dog.dat";
        let d1 = Dog(color: "blue", owner: p2);
        NSKeyedArchiver.archiveRootObject(d1, toFile: dogPath);
        
        var d2 = NSKeyedUnarchiver.unarchiveObjectWithFile(dogPath) as! Dog;
        print(d2.color, d2.owner.firstName, d2.owner.lastName);
        
        let arrayPath = NSTemporaryDirectory() + "array.dat";
        let array: NSArray = ["stam", p1, d1];
        NSKeyedArchiver.archiveRootObject(array, toFile: arrayPath);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  Using the Camera
//
//  Created by Guy Azran on 12/7/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var beenHereBefore = false;
    var controller: UIImagePickerController?;
    var imageView: UIImageView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 300));
        imageView.contentMode = .ScaleAspectFit;
        imageView.center = view.center;
        view.addSubview(imageView);
        
        //print("does camera support shooting videos = \(doesCameraSupportShootingVideos())");
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        if beenHereBefore{
            return
        }
        beenHereBefore = true;
        
        if isCameraAvailable() && doesCameraSupportShootingPhotos(){
            controller = UIImagePickerController();
            if let theController = controller{
                theController.sourceType = .Camera;
                theController.mediaTypes = [kUTTypeImage as String];
                theController.delegate = self;
                theController.allowsEditing = true;
                presentViewController(theController, animated: true, completion: nil);
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print("picker returned successfully");
        let mediaType:AnyObject? = info[UIImagePickerControllerMediaType];
        if let type:AnyObject = mediaType{
            if type is String{
                let stringType = type as! String;
                if stringType == kUTTypeImage as String{
                    let metaData = info[UIImagePickerControllerMediaMetadata] as? NSDictionary;
                    if let theMetaData = metaData{
                        let image = info[UIImagePickerControllerOriginalImage] as! UIImage;
                        print("the metaData = \(theMetaData)");
                        imageView.image = image;
                    }
                } else{
                    //the media is a video
                }
            }
        }
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("cancelled");
        picker.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func isCameraAvailable()->Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera);
    }
    
    func cameraSupportsMedia(mediaType: String, sourceType: UIImagePickerControllerSourceType)->Bool{
        
        let availableMediaTypes = UIImagePickerController.availableMediaTypesForSourceType(sourceType);
        
        if let theAvailableMediaTypes = availableMediaTypes{
            for type in theAvailableMediaTypes{
                print("type = \(type)");
                if type == mediaType{
                    return true;
                }
            }
        }
        return false;
    }
    
    func doesCameraSupportShootingVideos()->Bool{
        return cameraSupportsMedia(kUTTypeMovie as String, sourceType: .Camera);
    }
    
    func doesCameraSupportShootingPhotos()->Bool{
        return cameraSupportsMedia(kUTTypeImage as String, sourceType: .Camera);
    }
    
    func isFrontCameraAvailable()->Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.Front);
    }

    func isRearCameraAvailable()->Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.Rear);
    }
    
    func isFlashAvailableOnFrontCamera()->Bool{
        return UIImagePickerController.isFlashAvailableForCameraDevice(.Front);
    }
    
    func isFlashAvailableOnRearCamera()->Bool{
        return UIImagePickerController.isFlashAvailableForCameraDevice(.Rear);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


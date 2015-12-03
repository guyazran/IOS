//
//  ViewController.swift
//  Playing Audio Files
//
//  Created by Guy Azran on 12/3/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer: AVAudioPlayer?;
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("did finish playing");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue) { [weak self]() -> Void in
            let mainBundle = NSBundle.mainBundle();
            let filePatch = mainBundle.pathForResource("Nod Ya Head", ofType: "mp3");
            if let thePath = filePatch{
                let fileData = NSData(contentsOfFile: thePath);
                do{
                    self!.audioPlayer = try AVAudioPlayer(data: fileData!);
                    self!.audioPlayer!.delegate = self;
                    if self!.audioPlayer!.prepareToPlay() && self!.audioPlayer!.play(){
                        //audio is now playing;
                    }
                } catch{
                    print("error occured");
                }
            } else{
                print("error finding the file");
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  Playing Video Files
//
//  Created by Guy Azran on 12/3/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class ViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    var moviePlayer: AVPlayerViewController?;
    var playButton: UIButton!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton = UIButton(type: .System);
        playButton.frame = CGRect(x: 0, y: 0, width: 200, height: 30);
        playButton.center = view.center;
        playButton.setTitle("Play Video", forState: .Normal);
        playButton.addTarget(self, action: "startPlayingVideo", forControlEvents: .TouchUpInside);
        view.addSubview(playButton);
    }
    
    func startPlayingVideo(){
        moviePlayer = AVPlayerViewController(nibName: "", bundle: NSBundle.mainBundle());
        moviePlayer!.delegate = self;
        let url = NSBundle.mainBundle().URLForResource("bla", withExtension: ".mov");
        moviePlayer!.player = AVPlayer(URL: url!);
        //presentViewController(moviePlayer!, animated: true, completion: nil);
        moviePlayer!.view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 250);
        view.addSubview(moviePlayer!.view);
        moviePlayer!.player!.play();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


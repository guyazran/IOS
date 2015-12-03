//
//  ViewController.swift
//  Recording Audio
//
//  Created by Guy Azran on 12/3/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder?;
    var audioPlayer: AVAudioPlayer?;
    
    var btnToggleRecording: UIButton!;
    var startRecordingLabel = "Start Recording";
    var stopRecordingLabel = "Stop Recording";
    
    var recordingAllowed = true;
    var isRecording = false;
    
    func startRecordingAudio(){
        if !recordingAllowed{
            return;
        }
        
        let audioRecordingURL = audioRecordingPath();
        do{
            audioRecorder = try AVAudioRecorder(URL: audioRecordingURL!, settings: audioRecordingSettings());
            audioRecorder!.delegate = self;
            
            if audioRecorder!.prepareToRecord() && audioRecorder!.record(){
                //audio is recording
            }
            
        } catch{
            print("failed creating recorder");
        }
        
    }
    
    func stopRecordingAudio(){
        if let theAudioRecorder = audioRecorder{
            if theAudioRecorder.recording{
                theAudioRecorder.stop();
            }
        }
    }
    
    func audioRecordingPath() -> NSURL?{
        let fileManager = NSFileManager();
        do{
            let documentsFolderUrl = try fileManager.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: false);
            print("documentsFolderUrl = \(documentsFolderUrl)")
            return documentsFolderUrl.URLByAppendingPathComponent("recording.m4a");
        }catch{
            print("error getting recording path");
        }
        
        return nil;
    }
    
    func audioRecordingSettings() -> [String : AnyObject]{
        return [
            AVFormatIDKey : NSNumber(unsignedInt: kAudioFormatMPEG4AAC),
            AVSampleRateKey : 16000 as NSNumber,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey : AVAudioQuality.Low.rawValue as NSNumber
        ];
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        isRecording = false;
        if flag{
            do{
                let fileData = try NSData(contentsOfURL: audioRecordingPath()!, options: NSDataReadingOptions.MappedRead);
                audioPlayer = try AVAudioPlayer(data: fileData);
                audioPlayer!.delegate = self;
                if audioPlayer!.prepareToPlay() && audioPlayer!.play(){
                    //audio is playing
                }
                audioRecorder = nil;
            }catch{
                print("error playing audio");
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize button
        btnToggleRecording = UIButton(type: .System);
        btnToggleRecording.frame = CGRect(x: 0, y: 0, width: 200, height: 30);
        btnToggleRecording.center = view.center;
        btnToggleRecording.addTarget(self, action: "btnToggleRecording:", forControlEvents: .TouchUpInside);
        btnToggleRecording.setTitle(startRecordingLabel, forState: .Normal);
        view.addSubview(btnToggleRecording);
        
        //ask for permission to record
        let session = AVAudioSession.sharedInstance();
        
        do{
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions:  AVAudioSessionCategoryOptions.DuckOthers);
            try session.setActive(true);
            session.requestRecordPermission({ [weak self](allowed) -> Void in
                self!.recordingAllowed = allowed;
            })
            
        }catch{
            print("error creating session");
        }
    }
    
    func btnToggleRecording(sender: UIButton){
        if !isRecording{
            startRecordingAudio();
            sender.setTitle(stopRecordingLabel, forState: .Normal);
        } else{
            stopRecordingAudio();
            sender.setTitle(startRecordingLabel, forState: .Normal);
        }
        isRecording = !isRecording;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


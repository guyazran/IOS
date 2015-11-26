//
//  ViewController.swift
//  TCP Client
//
//  Created by Guy Azran on 11/26/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSStreamDelegate {

    var inputStream: NSInputStream?;
    var outputStream: NSOutputStream?;
    let host: CFString = "127.0.0.1";
    let port: UInt32 = 3000;
    var f = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connect();
    }
    
    func connect(){
        var readStream: Unmanaged<CFReadStream>?;
        var writeStream: Unmanaged<CFWriteStream>?;
        
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, host, port, &readStream, &writeStream);
        
        if let theReadStream = readStream{
            inputStream = theReadStream.takeUnretainedValue();
            inputStream!.delegate = self;
            inputStream!.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode);
            inputStream!.open();
        }
        if let theWriteStream = writeStream{
            outputStream = theWriteStream.takeUnretainedValue();
            outputStream!.delegate = self;
            outputStream!.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode);
            outputStream!.open();
        }
    }
    
    func disconnect(){
        if let theInputStream = inputStream{
            theInputStream.close();
            theInputStream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode);
            inputStream = nil;
        }
        if let theOutputStream = outputStream{
            theOutputStream.close();
            theOutputStream.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode);
            outputStream = nil;
        }
    }
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        switch (eventCode){
        case NSStreamEvent.ErrorOccurred:
            print("error occured");
        case NSStreamEvent.HasBytesAvailable:
            print("has bytes available");
            
            if (aStream === inputStream){
                var buffer = [UInt8](count: 1024, repeatedValue: 0);
                var actuallyRead:Int;
            
                actuallyRead = inputStream!.read(&buffer, maxLength: 1024);
                if actuallyRead > 0{
                    /*
                    //example how to read primitive values
                    let x = bytesToUInt64(buffer, offset: 0, length: 8);
                    let y = bytesToUInt32(buffer, offset: 8, length: 4)
                    print("x = \(x)");
                    print("y = \(y)");
                    */
                    
                    //example how to read a string
                    
                    //turn entire byte array to string
                    let responseFromServer = NSString(bytes: &buffer, length: actuallyRead, encoding: NSUTF8StringEncoding);
                    print(responseFromServer);
                    
                    //turn part of the byte array to string
                    //using NSData
                    let d = NSData(bytes: &buffer, length: actuallyRead);
                    let range = NSRange(location: 5, length: actuallyRead - 5);
                    let responseFromServerCut = NSString(data: d.subdataWithRange(range), encoding: NSUTF8StringEncoding);
                    print(responseFromServerCut);
                    
                    //Using an array
                    print(ViewController.bytesToString(buffer, offset: 5, length: actuallyRead - 5));
                }
                
                disconnect();
            }
            
            
        case NSStreamEvent.HasSpaceAvailable:
            print("has space available");
            if (aStream === outputStream){
                if f{
                    let data = NSMutableData();
                    
                    //example how to write primitive variables
                    let x:Int64 = 1234567891234567899;
                    let bytesOfInt = toByteArray(x.byteSwapped);
                    data.appendBytes(bytesOfInt, length: bytesOfInt.count);
                    
                    /*
                    //example how to write a string
                    let message = "hello!" as NSString;
                    data.appendData(message.dataUsingEncoding(NSUTF8StringEncoding)!);
                    */
                    
                    /*
                    //example how to write a byte
                    var b:UInt8 = 10;
                    data.appendBytes(&b, length: 1);
                    */
                    
                    outputStream!.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length);
                    f = false;
                    //disconnect();
                }
            
            }
        case NSStreamEvent.OpenCompleted:
            print("open completed");
        default:
            print("other event code");
        }
    }
    
    func toByteArray<T>(var value: T) -> [UInt8]{
        return withUnsafePointer(&value) {
            Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>($0), count: sizeof(T)));
        };
    }
    
    static func bytesToUInt64(bytes: [UInt8], offset: Int, length: Int) ->Int64{
        var result:Int64 = 0;
        
        for i in 0..<length{
            result += Int64(bytes[offset + i]) << Int64((length - 1 - i) * 8);
        }
        
        return result;
    }
    
    static func bytesToUInt32(bytes: [UInt8], offset: Int, length: Int) ->Int32{
        var result:Int32 = 0;
        
        for i in 0..<length{
            result += Int32(bytes[offset + i]) << Int32((length - 1 - i) * 8);
        }
        
        return result;
    }
    
    static func bytesToString(bytes: [UInt8], offset: Int, length: Int) -> NSString?{
        var temp = [UInt8]();
        for i in 0..<length{
            temp.append(bytes[offset + i]);
        }
        return NSString(bytes: temp, length: temp.count, encoding: NSUTF8StringEncoding);
    }
    
    deinit{
        disconnect();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


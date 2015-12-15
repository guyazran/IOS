//
//  ViewController.swift
//  Simple TCP Example
//
//  Created by Guy Azran on 12/15/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getServerTime();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getServerTime(){
        print("starting")
        let addr = "130.211.77.229"
        let port = 3000
        var inp: NSInputStream?
        var out: NSOutputStream?
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out);
        let inputStream = inp!
        let outputStream = out!
        inputStream.open()
        outputStream.open()
        var buffer: [UInt8] = [1] //"get" in ASCII
        buffer[0]=1;
        let data = NSMutableData();
        outputStream.write(&buffer, maxLength: buffer.count)
        let message = "delivery_manager" as NSString;
        data.appendData(message.dataUsingEncoding(NSUTF8StringEncoding)!);
        buffer[0]=16;
        outputStream.write(&buffer, maxLength: buffer.count)
        
        outputStream.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length);
        
        var bytesRead = inputStream.read(&buffer, maxLength: 1)
        print(buffer[0]);
        var inputBuffer = [UInt8](count: 8, repeatedValue: 0)
        bytesRead = inputStream.read(&inputBuffer, maxLength: 8)
        var long:Int64 = bytesToInt64(&inputBuffer, offset: 0, length: 8)
        print(long);
        
        print(inp);
        print(out);
        
        defer{
            print("closing");
            if inp != nil{
                inp!.close()
                inp = nil;
            }
            
            if out != nil{
                out!.close()
                out = nil;
            }
            print(inp);
            print(out);
            
        }
        
    }
    
    
    
    
    func toByteArray<T>(var value: T) -> [UInt8]{
        return withUnsafePointer(&value, {
            Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>($0), count: sizeof(T)));
        });
    }
    
    func bytesToInt64(inout bytes: [UInt8], offset: Int, length: Int) ->Int64{
        var result:Int64 = 0;
        for var i = 0 ; i < length ; i++ {
            result += Int64(bytes[offset + i]) << Int64((length-1-i)*8);
        }
        
        return result;
    }
}

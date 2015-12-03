//
//  TCP Client.swift
//  WhatsApp Client TCP
//
//  Created by Guy Azran on 11/30/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import Foundation

protocol TCPClientDelegate{
    func didCheckForNewMessages();
    func didLogin(success: Bool);
    func didSignUp(success: Bool);
    func didReceiveMessage(msg: Message);
}

class TCPClient: NSObject, NSStreamDelegate{

    let kSignUp:UInt8 = 10;
    let kLogIn:UInt8 = 20;
    let kSendMessage:UInt8 = 30;
    let kCheckForMessages:UInt8 = 40;
    let kSuccess:UInt8 = 127;
    let kFailure:UInt8 = 126;
    
    var inputStream: NSInputStream?;
    var outputStream: NSOutputStream?;
    let host: CFString = "127.0.0.1";
    let port: UInt32 = 3000;
    var whatToDo:UInt8 = 0;
    var data = NSMutableData();
    var dataUsernameAndPassword = NSMutableData();
    
    var delegate: TCPClientDelegate?
    
    
    func setUser(name: String, andPassword pass: String){
        let usernameBytes = (name as NSString).dataUsingEncoding(NSUTF8StringEncoding);
        var usernameLength = Int8(usernameBytes!.length);
        
        dataUsernameAndPassword.appendBytes(&usernameLength, length: 1);
        dataUsernameAndPassword.appendData(usernameBytes!);
        
        let passwordBytes = (pass as NSString).dataUsingEncoding(NSUTF8StringEncoding);
        var passwordLength = Int8(passwordBytes!.length);
        
        dataUsernameAndPassword.appendBytes(&passwordLength, length: 1);
        dataUsernameAndPassword.appendData(passwordBytes!);
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
            if (aStream === inputStream){
                switch whatToDo{
                case kSignUp:
                    print("sign up");
                    
                    var byte:UInt8 = 0;
                    var actuallyRead:Int;
                    
                    actuallyRead = inputStream!.read(&byte, maxLength: 1);
                    if actuallyRead > 0{
                        print("sign up \(byte == kSuccess ? "success" : "failure")");
                        whatToDo = 0;
                        disconnect();
                        delegate?.didSignUp(byte == kSuccess)
                    }
                case kLogIn:
                    print("log in");
                    
                    var byte:UInt8 = 0;
                    var actuallyRead:Int;
                    
                    actuallyRead = inputStream!.read(&byte, maxLength: 1);
                    if actuallyRead > 0{
                        print("log in \(byte == kSuccess ? "success" : "failure")");
                        whatToDo = 0;
                        disconnect();
                        delegate?.didLogin(byte == kSuccess);
                    }
                case kSendMessage:
                    print("send message");
                    
                    var byte:UInt8 = 0;
                    var actuallyRead:Int;
                    
                    actuallyRead = inputStream!.read(&byte, maxLength: 1);
                    if actuallyRead > 0{
                        print("send message \(byte == kSuccess ? "Successful" : "Failed")");
                        whatToDo = 0;
                        disconnect();
                    }
                case kCheckForMessages:
                    print("check for messages");
                    
                    var byte:UInt8 = 0;
                    var actuallyRead:Int;
                    var buffer = [UInt8](count: 1024, repeatedValue: 0)
                    
                    actuallyRead = inputStream!.read(&byte, maxLength: 1);
                    while actuallyRead > 0{
                        let contentLength = Int(byte);
                        inputStream!.read(&buffer, maxLength: contentLength);
                        let content = NSString(bytes: buffer, length: contentLength, encoding: NSUTF8StringEncoding) as! String;
                        print("content = \(content)");
                        
                        actuallyRead = inputStream!.read(&byte, maxLength: 1);
                        let senderLength = Int(byte);
                        inputStream!.read(&buffer, maxLength: senderLength);
                        let sender = NSString(bytes: buffer, length: senderLength, encoding: NSUTF8StringEncoding) as! String;
                        print("sender = \(sender)");
                        
                        let msg = Message(sender: sender, content: content);
                        delegate?.didReceiveMessage(msg);
                        
                        actuallyRead = inputStream!.read(&byte, maxLength: 1);
                    }
                    
                    whatToDo = 0;
                    disconnect();
                    delegate?.didCheckForNewMessages();
                    
                    
                default:
                    print("other");
                    whatToDo = 0;
                }
            }
            
        case NSStreamEvent.HasSpaceAvailable:
            if (aStream === outputStream){
                if data.length > 0{
                    outputStream!.write(UnsafePointer<UInt8>(data.bytes), maxLength: data.length);
                }
                data.length = 0;
            }
        case NSStreamEvent.OpenCompleted:
            break;
        default:
            print("other event code: \(eventCode)");
        }
    }
    
    static func toByteArray<T>(var value: T) -> [UInt8]{
        return withUnsafePointer(&value) {
            Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>($0), count: sizeof(T)));
        };
    }
    
    static func bytesToUInt64(inout bytes: [UInt8], offset: Int, length: Int) ->Int64{
        var result:Int64 = 0;
        
        for i in 0..<length{
            result += Int64(bytes[offset + i]) << Int64((length - 1 - i) * 8);
        }
        
        return result;
    }
    
    static func bytesToUInt32(inout bytes: [UInt8], offset: Int, length: Int) ->Int32{
        var result:Int32 = 0;
        
        for i in 0..<length{
            result += Int32(bytes[offset + i]) << Int32((length - 1 - i) * 8);
        }
        
        return result;
    }
    
    static func bytesToFloat32(inout bytes: [UInt8], offset: Int, length: Int) -> Float32{
        var reverseBytes = [UInt8]();
        for var i = length - 1; i >= 0; i-- {
            reverseBytes.append(bytes[offset + i]);
        }
        
        var f: Float32 = 0.0;
        
        memccpy(&f, reverseBytes, 0, 4);
        
        return f;
    }
    
    static func bytesToString(inout bytes: [UInt8], offset: Int, length: Int) -> NSString?{
        var temp = [UInt8]();
        for i in 0..<length{
            temp.append(bytes[offset + i]);
        }
        return NSString(bytes: temp, length: temp.count, encoding: NSUTF8StringEncoding);
    }
    
    deinit{
        disconnect();
    }
    
    
    //business logic functions
    
    func sendMessage(content: String, recipient: String){
        whatToDo = kSendMessage;
        data.appendBytes(&whatToDo, length: 1);
        data.appendData(dataUsernameAndPassword);
        
        let contentBytes = (content as NSString).dataUsingEncoding(NSUTF8StringEncoding);
        var contentLength = Int8(contentBytes!.length);
        data.appendBytes(&contentLength, length: 1);
        data.appendData(contentBytes!);
        
        let recipientBytes = (recipient as NSString).dataUsingEncoding(NSUTF8StringEncoding);
        var recipientLength = Int8(recipientBytes!.length);
        data.appendBytes(&recipientLength, length: 1);
        data.appendData(recipientBytes!);
        
        connect();
    }
    
    func login(){
        whatToDo = kLogIn
        data.appendBytes(&whatToDo, length: 1);
        data.appendData(dataUsernameAndPassword);
        connect();
    }
    
    func signup(){
        whatToDo = kSignUp;
        data.appendBytes(&whatToDo, length: 1);
        data.appendData(dataUsernameAndPassword);
        connect();
    }
    
    func checkForMessages(){
        whatToDo = kCheckForMessages;
        data.appendBytes(&whatToDo, length: 1);
        data.appendData(dataUsernameAndPassword);
        connect();
    }
    
    
    
    
    
}
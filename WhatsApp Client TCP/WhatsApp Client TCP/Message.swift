//
//  Message.swift
//  WhatsApp Client TCP
//
//  Created by Guy Azran on 11/30/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import Foundation

class Message {
    var sender: String;
    var content: String;
    init(sender: String, content: String){
        self.content = content;
        self.sender = sender;
    }
}
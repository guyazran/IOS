//
//  Message.swift
//  Learning TableView
//
//  Created by Guy Azran on 11/5/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import Foundation

class Message {
    private var _sender: String;
    private var _content: String;
    
    init(sender: String, content: String){
        self._sender = sender;
        self._content = content;
    }
    
    var sender:String{
        get{
            return _sender;
        }set{
            _sender = newValue;
        }
    }
    
    var content:String{
        get{
            return _content;
        } set{
            _content = newValue;
        }
    }
    
}
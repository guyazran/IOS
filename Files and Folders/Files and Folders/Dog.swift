//
//  Dog.swift
//  Files and Folders
//
//  Created by Guy Azran on 12/7/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import Foundation

@objc(Dog) class Dog: NSObject, NSCoding {
    var color: String;
    var owner: Person;
    
    struct SerializationKey {
        static let COLOR = "color";
        static let OWNER = "owner";
    }
    
    init(color: String, owner: Person) {
        self.color = color;
        self.owner = owner;
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.color = aDecoder.decodeObjectForKey(SerializationKey.COLOR) as! String;
        self.owner = aDecoder.decodeObjectForKey(SerializationKey.OWNER) as! Person;
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(color, forKey: SerializationKey.COLOR);
        aCoder.encodeObject(owner, forKey: SerializationKey.OWNER);
    }
}
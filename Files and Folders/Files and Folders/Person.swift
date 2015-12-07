//
//  Person.swift
//  Files and Folders
//
//  Created by Guy Azran on 12/7/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import Foundation


@objc(Person) class Person: NSObject, NSCoding {
    var firstName: String;
    var lastName: String;
    
    struct SerializationKey {
        static let FIRST_NAME = "firstName";
        static let LAST_NAME = "lastName";
    }
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName;
        self.lastName = lastName;
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObjectForKey(SerializationKey.FIRST_NAME) as! String;
        self.lastName = aDecoder.decodeObjectForKey(SerializationKey.LAST_NAME) as! String;
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.firstName, forKey: SerializationKey.FIRST_NAME);
        aCoder.encodeObject(self.lastName, forKey: SerializationKey.LAST_NAME);
    }
}

//
//  Person.swift
//  Learning Core Data
//
//  Created by Guy Azran on 12/10/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import Foundation
import CoreData

@objc(Person) class Person: NSManagedObject {
    @NSManaged var age: NSNumber;
    @NSManaged var firstName: String;
    @NSManaged var lastName: String;
}
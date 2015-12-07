//
//  ViewController.swift
//  Address Book
//
//  Created by Guy Azran on 12/7/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import ContactsUI

class ViewController: UIViewController, CNContactPickerDelegate {

    var contactPicker: CNContactPickerViewController!;
    var btnShowContacts: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnShowContacts = UIButton(type: .System);
        btnShowContacts.frame = CGRect(x: 0, y: 0, width: 200, height: 30);
        btnShowContacts.center = view.center;
        btnShowContacts.setTitle("Show Contacts", forState: UIControlState.Normal);
        btnShowContacts.addTarget(self, action: "showContacts", forControlEvents: UIControlEvents.TouchUpInside);
        view.addSubview(btnShowContacts);
        
        contactPicker = CNContactPickerViewController();
        contactPicker.delegate = self;
        
    }
    
    func showContacts(){
        presentViewController(contactPicker, animated: true, completion: nil);
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        print("did select contact \(contact.givenName)");
        let phoneNumbers = contact.phoneNumbers;
        for phoneNumber in phoneNumbers{
            print((phoneNumber.value as! CNPhoneNumber).stringValue);
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


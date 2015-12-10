//
//  ViewController.swift
//  Calendar
//
//  Created by Guy Azran on 12/10/15.
//  Copyright © 2015 Guy Azran. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {

    var calendar: EKCalendar?;
    var eventStore: EKEventStore?;
    
    var button: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        askPermissionToAccessCalendar();
        
        button = UIButton(type: .System);
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 30);
        button.center = view.center
        button.setTitle("add event", forState: .Normal);
        button.addTarget(self, action: "handleButton", forControlEvents: .TouchUpInside);
        view.addSubview(button);
    }
    
    func handleButton(){
        /*
        //add event
        if let theCalendar = calendar{
            let startDate = NSDate();
            let endDate = startDate.dateByAddingTimeInterval(24 * 60 * 60);
            createEventWithTitle("HackerU class", fromStartDate: startDate, toEndDate: endDate, inCalendar: theCalendar, inEventStore: eventStore!, withNotes: "a very long class");
        }
        */
        
        //read event
        readEvents();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func askPermissionToAccessCalendar(){
        eventStore = EKEventStore();
        switch(EKEventStore.authorizationStatusForEntityType(.Event)){
        case .Authorized:
            print("authorized");
            extractEventEntityOutOfStore(eventStore!);
        case .Denied:
            print("denied");
        case .NotDetermined:
            print("not determined");
            eventStore!.requestAccessToEntityType(.Event, completion: { [weak self](granted, error) -> Void in
                if granted{
                    print("granted");
                    self!.extractEventEntityOutOfStore(self!.eventStore!);
                } else{
                    print("access denied");
                }
            });
        case .Restricted:
            print("restricted");
        }
    }
    
    func extractEventEntityOutOfStore(eventStore: EKEventStore){
        let calendars = eventStore.calendarsForEntityType(.Event);
        
        for cal in calendars{
            print("calendar title = \(cal.title)");
            
            switch(cal.type){
            case .Birthday:
                print("calendar type = Birthday");
            case .CalDAV:
                print("calendar type = CalDAV");
            case .Exchange:
                print("calendar type = Exchange");
            case .Local:
                print("calendar type = Local");
            case .Subscription:
                print("calendar type = subScription");
            }
            
            if cal.allowsContentModifications{
                self.calendar = cal;
            }
            
            print("calendar allows modifications = \(cal.allowsContentModifications)");
            let color = UIColor(CGColor: cal.CGColor);
            print("calendar color = \(color)");
            print("---------------------------------");
        }
    }
    
    func createEventWithTitle(title: String, fromStartDate startDate: NSDate, toEndDate endDate: NSDate, inCalendar calendar: EKCalendar, inEventStore eventStore: EKEventStore, withNotes notes: String) ->Bool{
        
        if calendar.allowsContentModifications == false{
            print("the selected calendar doesn't allow modification");
            return false;
        }
        
        //create an event
        let event = EKEvent(eventStore: eventStore);
        event.calendar = calendar;
        
        //set the properties of the event
        event.title = title;
        event.notes = notes;
        event.startDate = startDate;
        event.endDate = endDate;
        
        //save the event into the calendar
        do{
            try eventStore.saveEvent(event, span: .ThisEvent);
            return true;
        } catch{
            print("error saving event");
            return false;
        }
    }
    
    func readEvents(){
        let now = NSDate();
        let startDate = now.dateByAddingTimeInterval(-1 * 60 * 60);
        let endDate = now.dateByAddingTimeInterval(2 * 24 * 60 * 60);
        let searchPredicate = eventStore!.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: [calendar!]);
        
        let events = eventStore!.eventsMatchingPredicate(searchPredicate);
        
        for event in events{
            print("event title: \(event.title)");
            print("start date: \(event.startDate)");
            print("endDate: \(endDate)");
            print("notes: \(event.notes)");
        }
    }
}






